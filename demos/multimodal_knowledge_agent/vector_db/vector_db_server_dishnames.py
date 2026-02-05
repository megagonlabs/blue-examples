"""
Vector Database Server
A FastAPI-based server that indexes JSONL data and supports similarity search using ChromaDB.
Embeddings are persisted to disk and loaded on subsequent runs.
Supports multiple data sources (JSONL files).
"""

import json
import math
import os
import random
import uuid
from pathlib import Path
from typing import List, Dict, Any, Optional, Set, Tuple

import chromadb
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from openai import OpenAI

# Initialize OpenAI client
client = OpenAI()

def load_recipe_data_path():
    """Load recipe_data_path from agent.json."""
    script_dir = Path(__file__).parent
    agent_json_path = script_dir.parent / "agents" / "blue_plate" / "agent.json"
    
    if agent_json_path.exists():
        try:
            with open(agent_json_path, "r") as f:
                config = json.load(f)
                recipe_path = config.get("recipe_data_path", "./recipe_data")
                # Convert relative path to absolute
                if not os.path.isabs(recipe_path):
                    recipe_path = script_dir / recipe_path
                else:
                    recipe_path = Path(recipe_path)
                return recipe_path.resolve()
        except Exception as e:
            print(f"Warning: Failed to load agent.json: {e}")
            return script_dir / "recipe_data"
    else:
        return script_dir / "recipe_data"

# Embedding model
EMBEDDING_MODEL = "text-embedding-3-small"

# ChromaDB persistence directory
CHROMA_PERSIST_DIR = Path(__file__).parent / "chroma_db"
COLLECTION_NAME = "recipes"

# Auto-index settings
AUTO_INDEX_JSONL_DIR = load_recipe_data_path()
AUTO_INDEX_MAX_ROWS = None  # Set to None to index all rows
AUTO_INDEX_SAMPLE_PCT = 10  # Set to None to index 100% (no sampling)

# Memory optimization settings
BATCH_SIZE = 500  # Reduced from 1500 to lower memory usage
QUERY_BATCH_SIZE = 100  # Limit results fetched in a single query

# FastAPI app
app = FastAPI(title="Vector Database API", version="1.0.0")

# Initialize ChromaDB client with persistence and memory settings
chroma_client = chromadb.PersistentClient(
    path=str(CHROMA_PERSIST_DIR)
)

# Global collection reference
collection: Optional[chromadb.Collection] = None


class QueryRequest(BaseModel):
    query: str
    top_k: int = 5
    source: Optional[str] = None  # Filter by source file


class QueryResult(BaseModel):
    index: int
    score: float
    document: Dict[str, Any]
    source: str  # Source file name


class QueryResponse(BaseModel):
    query: str
    results: List[QueryResult]


class IndexRequest(BaseModel):
    file_path: str
    max_rows: Optional[int] = None  # Randomly sample this many rows (None for all)
    sample_pct: Optional[float] = None  # Randomly sample this percentage of rows (None for all)
    random_seed: Optional[int] = None  # Seed for reproducible sampling


class IndexResponse(BaseModel):
    message: str
    num_documents: int
    total_documents: int  # Total documents in collection


def embed_texts(texts: List[str], model: str = EMBEDDING_MODEL) -> List[List[float]]:
    """
    Convert a list of texts into embedding vectors using OpenAI's embedding models.
    Filters out empty/None strings to avoid invalid requests.
    """
    sanitized_texts = []
    for t in texts:
        if t is None:
            continue
        cleaned = str(t).strip().replace("\n", " ")
        if not cleaned:
            continue
        sanitized_texts.append(cleaned)
    if not sanitized_texts:
        raise ValueError("No valid texts to embed")

    response = client.embeddings.create(
        model=model,
        input=sanitized_texts,
    )

    embeddings: List[List[float]] = [item.embedding for item in response.data]
    return embeddings


def json_to_string(obj: Dict[str, Any]) -> str:
    """
    Convert a JSON object to a string representation for embedding.
    Handles nested structures like lists and dicts.
    """
    parts = []
    for key, value in obj.items():
        if isinstance(value, list):
            if value and isinstance(value[0], dict):
                # List of dicts (e.g., reviews)
                value_str = "; ".join([json.dumps(v) for v in value])
            else:
                value_str = ", ".join([str(v) for v in value])
        elif isinstance(value, dict):
            value_str = json.dumps(value)
        else:
            value_str = str(value)
        parts.append(f"{key}: {value_str}")
    
    return " | ".join(parts)


def get_or_create_collection() -> chromadb.Collection:
    """Get existing collection or create a new one."""
    global collection
    if collection is None:
        collection = chroma_client.get_or_create_collection(
            name=COLLECTION_NAME,
            metadata={"hnsw:space": "cosine"}  # Use cosine similarity
        )
    return collection


def collection_has_data() -> bool:
    """Check if the collection already has indexed data."""
    coll = get_or_create_collection()
    return coll.count() > 0


def get_indexed_sources() -> List[str]:
    """Get list of all indexed source files."""
    coll = get_or_create_collection()
    if coll.count() == 0:
        return []
    
    all_data = coll.get(include=["metadatas"])
    sources = set()
    for metadata in all_data["metadatas"]:
        if "source" in metadata:
            sources.add(metadata["source"])
    return sorted(list(sources))


def is_source_indexed(source_name: str) -> bool:
    """Check if a source file is already indexed."""
    return source_name in get_indexed_sources()


def _plan_sampling(
    file_path: Path,
    max_rows: Optional[int],
    sample_pct: Optional[float],
    random_seed: Optional[int],
) -> Tuple[Optional[Set[int]], Optional[int]]:
    """Decide which row indices to keep. Returns (indices_set_or_None, sample_size_or_None)."""
    if max_rows is not None and sample_pct is not None:
        raise ValueError("Specify either max_rows or sample_pct, not both")

    # No sampling requested: take all rows
    if max_rows is None and sample_pct is None:
        return None, None

    if sample_pct is not None:
        if not (0 < sample_pct <= 100):
            raise ValueError("sample_pct must be in (0, 100]")

    if max_rows is not None and max_rows <= 0:
        raise ValueError("max_rows must be positive when provided")

    # Count total lines (first pass) to size the sample
    with open(file_path, "r", encoding="utf-8") as f:
        total_lines = sum(1 for _ in f)

    if total_lines == 0:
        raise ValueError("File is empty; nothing to index")

    rng = random.Random(random_seed)

    if sample_pct is not None:
        sample_size = max(1, math.ceil(total_lines * (sample_pct / 100.0)))
    else:
        sample_size = min(max_rows, total_lines)

    sample_indices = set(rng.sample(range(total_lines), sample_size))
    return sample_indices, sample_size


def add_documents_from_jsonl(
    file_path: str,
    max_rows: Optional[int] = None,
    sample_pct: Optional[float] = None,
    random_seed: Optional[int] = None,
) -> int:
    """
    Add documents from a JSONL file to the collection.
    Skips if the source file is already indexed.
    Returns number of documents added.
    Uses streaming to avoid memory issues with large files.
    
    :param file_path: Path to the JSONL file
    :param max_rows: Randomly sample this many rows (None for all rows)
    :param sample_pct: Randomly sample this percentage of rows (None for all rows)
    :param random_seed: Seed for reproducible sampling (optional)
    """
    coll = get_or_create_collection()
    
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"File not found: {file_path}")
    
    # Decide sampling plan up front (this may read the file once to count rows)
    sample_indices, sample_size = _plan_sampling(path, max_rows, sample_pct, random_seed)

    source_name = path.name
    if sample_pct is not None:
        pct_label = f"{sample_pct:g}".replace(".", "p")
        source_name = f"{path.stem}_pct{pct_label}{path.suffix}"
    elif max_rows is not None and sample_size is not None:
        source_name = f"{path.stem}_sample{sample_size}{path.suffix}"
    
    # Check if already indexed
    if is_source_indexed(source_name):
        print(f"Source '{source_name}' is already indexed. Skipping.")
        return 0
    
    # Get current max index in collection for global indexing
    current_count = coll.count()
    
    # Process in batches to avoid memory and API limits
    # Use module-level BATCH_SIZE for consistency
    total_added = 0
    skipped = 0
    
    batch_docs = []
    batch_texts = []
    batch_ids = []
    batch_metadatas = []
    
    print(f"Loading and indexing documents from '{source_name}' (batch size: {BATCH_SIZE})...", flush=True)
    
    with open(path, "r", encoding="utf-8") as f:
        for local_idx, line in enumerate(f):
            if sample_indices is not None and local_idx not in sample_indices:
                continue

            line = line.strip()
            if not line:
                continue
            
            doc = json.loads(line)
            # Use dish name; fallback to recipe_id; skip if missing/empty
            raw_name = doc.get('name')
            raw_recipe_id = doc.get('recipe_id')
            name_val = raw_name if isinstance(raw_name, str) else None
            rid_val = raw_recipe_id if isinstance(raw_recipe_id, str) else None
            info_for_embedding = (name_val or rid_val or "").strip()
            if not info_for_embedding or info_for_embedding == None:
                skipped += 1
                print(f"  Skipping document at line {local_idx + 1} due to missing 'name' and 'recipe_id'.", flush=True)
                continue

            doc_id = str(uuid.uuid4())
            global_index = current_count + local_idx
            
            batch_docs.append(doc)
            batch_texts.append(info_for_embedding)
            batch_ids.append(doc_id)
            batch_metadatas.append({
                "original_doc": json.dumps(doc),
                "index": global_index,
                "local_index": local_idx,
                "source": source_name,
            })
            
            # Process batch when full
            if len(batch_docs) >= BATCH_SIZE:
                batch_num = (total_added // BATCH_SIZE) + 1
                print(f"  Processing batch {batch_num} (rows {total_added + 1}-{total_added + len(batch_docs)})...", flush=True)
                
                # Create embeddings for this batch
                batch_embeddings = embed_texts(batch_texts)
                
                # Add to ChromaDB
                coll.add(
                    ids=batch_ids,
                    embeddings=batch_embeddings,
                    documents=batch_texts,
                    metadatas=batch_metadatas,
                )
                
                total_added += len(batch_docs)
                
                # Clear batch
                batch_docs = []
                batch_texts = []
                batch_ids = []
                batch_metadatas = []
    
    # Process remaining documents
    if batch_docs:
        batch_num = (total_added // BATCH_SIZE) + 1
        print(f"  Processing final batch {batch_num} (rows {total_added + 1}-{total_added + len(batch_docs)})...", flush=True)
        batch_embeddings = embed_texts(batch_texts)
        coll.add(
            ids=batch_ids,
            embeddings=batch_embeddings,
            documents=batch_texts,
            metadatas=batch_metadatas,
        )
        total_added += len(batch_docs)
    
    print(f"Added {total_added} documents from '{source_name}' successfully! Skipped {skipped} documents.")
    print(f"Total documents in collection: {coll.count()}")
    return total_added


def load_and_index_jsonl(
    file_path: str,
    force_reindex: bool = False,
    max_rows: Optional[int] = None,
    sample_pct: Optional[float] = None,
    random_seed: Optional[int] = None,
) -> int:
    """
    Load a JSONL file and create embeddings for each row.
    If embeddings already exist in ChromaDB, skip indexing unless force_reindex is True.
    
    :param file_path: Path to the JSONL file
    :param force_reindex: If True, clear existing collection and reindex
    :param max_rows: Randomly sample this many rows (None for all rows)
    :param sample_pct: Randomly sample this percentage of rows (None for all rows)
    :param random_seed: Seed for reproducible sampling (optional)
    """
    global collection
    coll = get_or_create_collection()
    
    # Clear existing data if re-indexing
    if force_reindex and coll.count() > 0:
        print("Clearing existing collection for re-indexing...")
        chroma_client.delete_collection(name=COLLECTION_NAME)
        collection = None  # Reset global reference
        coll = get_or_create_collection()
    
    return add_documents_from_jsonl(
        file_path,
        max_rows=max_rows,
        sample_pct=sample_pct,
        random_seed=random_seed,
    )


@app.on_event("startup")
async def startup_event():
    """Load existing embeddings on startup or auto-index from recipe_data directory."""
    # Initialize collection
    coll = get_or_create_collection()
    
    if coll.count() > 0:
        print(f"Loaded existing collection with {coll.count()} documents from {CHROMA_PERSIST_DIR}")
        print(f"Indexed sources: {get_indexed_sources()}")
    else:
        # Auto-load from recipe_data directory (loaded from agent.json)
        if AUTO_INDEX_JSONL_DIR.exists():
            print(
                f"Auto-indexing JSONL files from {AUTO_INDEX_JSONL_DIR} "
                f"(max_rows={AUTO_INDEX_MAX_ROWS}, sample_pct={AUTO_INDEX_SAMPLE_PCT})..."
            )
            for jsonl_file in AUTO_INDEX_JSONL_DIR.glob("*.jsonl"):
                try:
                    add_documents_from_jsonl(
                        str(jsonl_file),
                        max_rows=AUTO_INDEX_MAX_ROWS,
                        sample_pct=AUTO_INDEX_SAMPLE_PCT,
                    )
                except Exception as e:
                    print(f"Error indexing {jsonl_file}: {e}")
        else:
            print(f"Recipe data directory not found: {AUTO_INDEX_JSONL_DIR}")
            print("No existing collection found. Use POST /index to add documents.")


@app.get("/")
async def root():
    """Health check endpoint."""
    coll = get_or_create_collection()
    return {
        "status": "ok",
        "message": "Vector Database API is running",
        "indexed_documents": coll.count(),
        "indexed_sources": get_indexed_sources(),
    }


@app.post("/index", response_model=IndexResponse)
async def index_documents(request: IndexRequest):
    """
    Index documents from a JSONL file (adds to existing collection).
    Each row is converted to a string and embedded.
    Skips if the source file is already indexed.
    Use max_rows parameter to limit the number of rows (for testing).
    """
    try:
        coll = get_or_create_collection()
        num_docs = add_documents_from_jsonl(
            request.file_path,
            max_rows=request.max_rows,
            sample_pct=request.sample_pct,
            random_seed=request.random_seed,
        )
        return IndexResponse(
            message="Documents indexed successfully" if num_docs > 0 else "Source already indexed, skipped",
            num_documents=num_docs,
            total_documents=coll.count(),
        )
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/reindex", response_model=IndexResponse)
async def reindex_documents(request: IndexRequest):
    """
    Force re-index documents from a JSONL file (clears ALL existing embeddings).
    Use max_rows parameter to limit the number of rows (for testing).
    """
    try:
        num_docs = load_and_index_jsonl(
            request.file_path,
            force_reindex=True,
            max_rows=request.max_rows,
            sample_pct=request.sample_pct,
            random_seed=request.random_seed,
        )
        coll = get_or_create_collection()
        return IndexResponse(
            message="Documents re-indexed successfully",
            num_documents=num_docs,
            total_documents=coll.count(),
        )
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/query", response_model=QueryResponse)
async def query_documents(request: QueryRequest):
    """
    Search for documents similar to the query using ChromaDB.
    Returns top_k results with their similarity scores and original documents.
    Optionally filter by source file using the 'source' parameter.
    """
    coll = get_or_create_collection()
    
    if coll.count() == 0:
        raise HTTPException(status_code=400, detail="No documents indexed. Please index documents first.")
    
    # Embed the query
    query_embedding = embed_texts([request.query])[0]
    
    # Build where clause for source filtering
    where_clause = None
    if request.source:
        where_clause = {"source": request.source}
    
    # Limit results to prevent memory issues
    # Don't fetch more than QUERY_BATCH_SIZE at once
    max_results = min(request.top_k, QUERY_BATCH_SIZE, coll.count())
    
    # Query ChromaDB - exclude documents to save memory
    results = coll.query(
        query_embeddings=[query_embedding],
        n_results=max_results,
        where=where_clause,
        include=["metadatas", "distances"]  # Removed "documents" to save memory
    )
    
    # Parse results
    query_results = []
    if results["metadatas"] and results["metadatas"][0]:
        for i, metadata in enumerate(results["metadatas"][0]):
            # ChromaDB returns distances (lower is more similar for cosine)
            # Convert distance to similarity score: similarity = 1 - distance
            distance = results["distances"][0][i] if results["distances"] else 0
            similarity_score = 1 - distance
            
            original_doc = json.loads(metadata["original_doc"])
            query_results.append(QueryResult(
                index=metadata["index"],
                score=similarity_score,
                document=original_doc,
                source=metadata.get("source", "unknown"),
            ))
    
    return QueryResponse(
        query=request.query,
        results=query_results,
    )


@app.get("/documents")
async def list_documents(source: Optional[str] = None):
    """List all indexed documents with their indices. Optionally filter by source."""
    coll = get_or_create_collection()
    
    if coll.count() == 0:
        return {"message": "No documents indexed", "documents": [], "sources": []}
    
    # Build where clause for source filtering
    where_clause = None
    if source:
        where_clause = {"source": source}
    
    # Get documents from collection (limited to prevent memory issues)
    # Fetch in smaller batches if collection is large
    total_count = coll.count()
    if total_count > QUERY_BATCH_SIZE and where_clause is None:
        # For large collections without filtering, limit results
        all_data = coll.get(include=["metadatas"], limit=QUERY_BATCH_SIZE)
    else:
        all_data = coll.get(include=["metadatas"], where=where_clause)
    
    documents_list = []
    for metadata in all_data["metadatas"]:
        original_doc = json.loads(metadata["original_doc"])
        documents_list.append({
            "index": metadata["index"],
            "name": original_doc.get("name", "N/A"),
            "recipe_id": original_doc.get("recipe_id", "N/A"),
            "source": metadata.get("source", "unknown"),
        })
    
    # Sort by index
    documents_list.sort(key=lambda x: x["index"])
    
    return {
        "num_documents": len(documents_list),
        "total_documents": coll.count(),
        "sources": get_indexed_sources(),
        "documents": documents_list,
    }


@app.get("/sources")
async def list_sources():
    """List all indexed source files."""
    coll = get_or_create_collection()
    sources = get_indexed_sources()
    
    return {
        "num_sources": len(sources),
        "total_documents": coll.count(),
        "sources": sources,
    }


@app.delete("/clear")
async def clear_collection():
    """Clear all documents from the collection."""
    global collection
    coll = get_or_create_collection()
    
    if coll.count() == 0:
        return {"message": "Collection is already empty"}
    
    chroma_client.delete_collection(name=COLLECTION_NAME)
    collection = None
    
    return {"message": "Collection cleared successfully"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
