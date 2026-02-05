#!/bin/bash
# Build all agents and start vector database server

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Start vector database server
echo "=== Starting Vector Database Server ==="
cd "$SCRIPT_DIR/../vector_db" && ./start_vector_db.sh

echo ""
echo "=== Building All Agents ==="
cd "$SCRIPT_DIR"
for dir in */; do
    if [ -f "$SCRIPT_DIR/$dir/docker_build_agent.sh" ]; then
        echo "Building agent in $dir..."
        cd "$SCRIPT_DIR/$dir" && ./docker_build_agent.sh
    fi
done

