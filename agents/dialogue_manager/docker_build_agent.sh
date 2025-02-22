#/bin/bash
echo 'Building docker image...'

# build docker
docker build --no-cache -t blue-agent-dialogue_manager:latest -f Dockerfile.agent .

# tag image
docker tag blue-agent-dialogue_manager:latest blue-agent-dialogue_manager:$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)

echo 'Done...'
