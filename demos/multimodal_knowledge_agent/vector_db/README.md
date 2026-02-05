# Vector Database Server

A vector search server using ChromaDB. It indexes documents from JSONL files and performs cosine similarity search using OpenAI Embeddings.

## Features

- Persistent vector storage with **ChromaDB**
- Uses **OpenAI Embeddings** (`text-embedding-3-small`)
- Automatic indexing from multiple JSONL files
- Filtering by source file
- Embeddings are automatically saved and reused on subsequent runs

## Setup

### Install Required Packages

```bash
cd /home/seiji/blue-plate
uv add chromadb fastapi uvicorn openai requests
```

### Environment Variables

Set your OpenAI API key:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

## Data Preparation

Place JSONL files in the `example_data/` directory. They will be automatically indexed when the server starts.

```
retrieval_agent/
├── example_data/        # Toy data directory 
│   ├── example_asian_recipes.jsonl
│   └── example_other_recipes.jsonl
├── recipe_data/         # Data directory
│   └── (additional JSONL files...)
├── vector_db_server_dishnames.py
└── chroma_db/  (auto-generated)
```

Each JSONL file should contain one JSON object per line.

## Starting the Server

### Using the Startup Script (Recommended)

The easiest way to start the server is using the provided script:

```bash
cd vector_db
./start_vector_db.sh
```

This script:
- Stops any existing server instance
- Starts the server in the background
- Logs output to `server.log`
- Verifies the server started successfully

**Note:** This script is automatically executed when running `./docker_build_all_agents.sh` from the `agents/` directory.

### Manual Start

Direct command:
```bash
cd vector_db
uv run python vector_db_server_dishnames.py
```

The server will start at `http://localhost:8000`.

### Run in Background (Manual)

```bash
cd vector_db
nohup uv run python vector_db_server_dishnames.py > server.log 2>&1 &
```

## API Endpoints

### Health Check

```bash
curl http://localhost:8000/
```

Example response:
```json
{
    "status": "ok",
    "message": "Vector Database API is running",
    "indexed_documents": 50,
    "indexed_sources": ["example_asian_recipes.jsonl", "example_other_recipes.jsonl"]
}
```

### Similarity Search

```bash
curl -X POST http://localhost:8000/query \
  -H "Content-Type: application/json" \
  -d '{"query": "spicy Asian noodles", "top_k": 5}'
```

Search only within a specific source:
```bash
curl -X POST http://localhost:8000/query \
  -H "Content-Type: application/json" \
  -d '{"query": "Italian pasta", "top_k": 3, "source": "example_other_recipes.jsonl"}'
```

### List Documents

All documents:
```bash
curl http://localhost:8000/documents
```

Filter by source:
```bash
curl "http://localhost:8000/documents?source=example_asian_recipes.jsonl"
```

### List Sources

```bash
curl http://localhost:8000/sources
```

### Index New File

```bash
curl -X POST http://localhost:8000/index \
  -H "Content-Type: application/json" \
  -d '{"file_path": "/path/to/new_data.jsonl"}'
```

### Reindex (Clears All Data First)

```bash
curl -X POST http://localhost:8000/reindex \
  -H "Content-Type: application/json" \
  -d '{"file_path": "/path/to/data.jsonl"}'
```

### Clear Collection

```bash
curl -X DELETE http://localhost:8000/clear
```

## Usage from Jupyter Notebook

You can use `retrieval_test.ipynb` for testing.

```python
import requests

BASE_URL = "http://localhost:8000"

# Execute a query
response = requests.post(
    f"{BASE_URL}/query",
    json={"query": "healthy breakfast", "top_k": 5}
)
results = response.json()

for r in results['results']:
    print(f"[{r['index']}] {r['document']['name']} (Score: {r['score']:.4f})")
```

## File Structure

```
retrieval_agent/
├── vector_db_server_dishnames.py   # Main server
├── retrieval_test.ipynb  # Test notebook
├── README.md             # This file
├── example_data/         # Toy data directory
│   ├── example_asian_recipes.jsonl
│   └── example_other_recipes.jsonl
├── recipe_data/          # Data directory
│   └── *.jsonl           # Data you want use
└── chroma_db/            # ChromaDB persistence directory (auto-generated)
```

## Notes

- On first startup, embeddings are created and saved to `chroma_db/`
- On subsequent startups, saved embeddings are loaded (no API calls needed)
- To recreate embeddings, delete `chroma_db/` and restart the server, or use the `/reindex` endpoint
- The same file will not be indexed twice
