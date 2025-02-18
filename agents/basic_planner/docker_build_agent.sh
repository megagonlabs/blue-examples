#/bin/bash
echo 'Building docker image...'

# build docker
docker build --no-cache -t blue-agent-basic_planner:latest -f Dockerfile.agent .

# tag image
docker tag blue-agent-basic_planner:latest blue-agent-basic_planner:$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)

echo 'Done...'
