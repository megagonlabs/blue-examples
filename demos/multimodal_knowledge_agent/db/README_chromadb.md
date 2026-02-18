# Vector Database Server

A vector search server using ChromaDB. It indexes documents from JSONL files and performs cosine similarity search using OpenAI Embeddings.

## Quick Tour

Get the vector database server up and running in 3 steps:

### 1. Install Dependencies

```bash
pip install chromadb fastapi uvicorn openai requests
```

Set your OpenAI API key:
```bash
export OPENAI_API_KEY="your-api-key-here"
```

### 2. Start the Server

```bash
cd db
./start_vector_db.sh
```

The server will start at `http://localhost:8000` and automatically index the example data.

**Note:** This script is automatically executed when running `./docker_build_all_agents.sh` from the [agents/](../agents/) directory.

### 3. Verify It's Working

Check server health:
```bash
curl http://localhost:8000/
```

Expected response:
```json
{
    "status": "ok",
    "message": "Vector Database API is running",
    "indexed_documents": 50,
    "indexed_sources": ["example_asian_recipes.jsonl", "example_other_recipes.jsonl"]
}
```

Try a simple search:
```bash
curl -X POST http://localhost:8000/query \
  -H "Content-Type: application/json" \
  -d '{"query": "spicy Asian noodles", "top_k": 3}'
```

✅ **Server is ready!** Return to the [main README](../README.md) for next steps.

---

## Detailed Documentation

### Features

- Persistent vector storage with **ChromaDB**
- Uses **OpenAI Embeddings** (`text-embedding-3-small`)
- Automatic indexing from multiple JSONL files
- Filtering by source file
- Embeddings are automatically saved and reused on subsequent runs

### Data Preparation

The server automatically indexes JSONL files from `example_data/` and `recipe_data/` directories on startup. Each JSONL file should contain one JSON object per line.

- **`example_data/`**: Toy sample data (already included, no setup needed)
- **`recipe_data/`**: Your real data (requires preprocessing from [data_prep/README.md](../data_prep/README.md))

**To use real external data:**
1. Follow preprocessing steps in [data_prep/README.md](../data_prep/README.md)
2. Copy the resulting JSONL to `recipe_data/`:
   ```bash
   cp data/recipes/processed/recipes_with_reviews.jsonl vector_db/recipe_data/
   ```
3. Restart the server (files will be indexed automatically)

#### Data Sampling Configuration

**By default, the server indexes only 10% of the data** to reduce compute costs and resource usage during development and testing.

To change this behavior, edit `vector_db_server_dishnames.py`:

```python
# Line ~54: Adjust sampling percentage based on your budget and compute resources
AUTO_INDEX_SAMPLE_PCT = 10  # Set to None to index 100% (no sampling)
```

**Configuration options:**
- `AUTO_INDEX_SAMPLE_PCT = 10` → Index 10% of data (default, recommended for testing)
- `AUTO_INDEX_SAMPLE_PCT = 50` → Index 50% of data
- `AUTO_INDEX_SAMPLE_PCT = None` → Index 100% of data (full indexing)

**Consider adjusting this value based on:**
- **Budget**: OpenAI embedding API costs scale with data volume
- **Compute resources**: More data requires more memory and processing time
- **Use case**: Testing vs. production deployment

After changing the setting, restart the server for changes to take effect.

