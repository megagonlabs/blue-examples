#/bin/bash
echo 'Publishing Basic Planner Agent...'

# tag and publish
docker tag blue-agent-basic_planner:latest megagonlabs/blue-agent-basic_planner:latest
docker tag blue-agent-basic_planner:latest megagonlabs/blue-agent-basic_planner:$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)

docker push megagonlabs/blue-agent-basic_planner:latest
docker push megagonlabs/blue-agent-basic_planner:$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)

echo 'Done...'
