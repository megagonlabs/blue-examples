#/bin/bash
echo 'Building WebSocketCounter Service...'
echo "${BLUE_CORE_DOCKER_ORG}/blue-service-websocket_counter:${BLUE_DEPLOY_VERSION}"
echo "plaforms: ${BLUE_BUILD_PLATFORM}"

# build docker
docker buildx build --platform ${BLUE_BUILD_PLATFORM} --no-cache --push -t ${BLUE_DEV_DOCKER_ORG}/blue-service-websocket_counter:${BLUE_DEPLOY_VERSION} -f Dockerfile.service .

echo 'Done...'
