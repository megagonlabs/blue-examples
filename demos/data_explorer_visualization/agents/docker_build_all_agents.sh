#!/bin/bash
# Build all agents and start vector database server

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "=== Building All Agents ==="
cd "$SCRIPT_DIR"
for dir in */; do
    if [ -f "$SCRIPT_DIR/$dir/docker_build_agent.sh" ]; then
        echo "Building agent in $dir..."
        cd "$SCRIPT_DIR/$dir" && ./docker_build_agent.sh
    fi
done

