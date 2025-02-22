#/bin/bash
echo 'Publishing Dialogue Manager Agent...'

# tag and publish
docker tag blue-agent-dialogue_manager:latest megagonlabs/blue-agent-dialogue_manager:latest
docker tag blue-agent-dialogue_manager:latest megagonlabs/blue-agent-dialogue_manager:$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)

docker push megagonlabs/blue-agent-dialogue_manager:latest
docker push megagonlabs/blue-agent-dialogue_manager:$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)

echo 'Done...'
