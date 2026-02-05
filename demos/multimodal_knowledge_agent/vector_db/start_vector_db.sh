#!/bin/bash
# Start vector database server in background

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$SCRIPT_DIR" || exit 1

echo "Starting vector database server (vector_db_server_dishnames.py)..."

# Stop any existing server
pkill -f "vector_db_server_dishnames.py" || true

# Start the server in background
# Use --project to specify the project root for uv
nohup uv run --project "$PROJECT_ROOT" python vector_db_server_dishnames.py > server.log 2>&1 &

# Get the PID
SERVER_PID=$!
echo "Vector database server started with PID: $SERVER_PID"
echo "Log file: $SCRIPT_DIR/server.log"

# Wait a moment to check if server started successfully
sleep 2

if ps -p $SERVER_PID > /dev/null; then
    echo "✓ Vector database server is running"
else
    echo "✗ Failed to start vector database server"
    echo "Check $SCRIPT_DIR/server.log for details"
    exit 1
fi
