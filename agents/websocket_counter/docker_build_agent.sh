#/bin/bash
echo 'Building docker image...'
echo "${BLUE_CORE_DOCKER_ORG}/blue-websocker_counter:${BLUE_DEPLOY_VERSION}"
echo "plaforms: ${BLUE_BUILD_PLATFORM}"

# build docker
docker buildx build --platform ${BLUE_BUILD_PLATFORM} --no-cache --push -t ${BLUE_DEV_DOCKER_ORG}/blue-websocker_counter:${BLUE_DEPLOY_VERSION} -f Dockerfile.agent .

echo 'Done...'
