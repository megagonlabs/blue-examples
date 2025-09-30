#/bin/bash
echo 'Building docker image...'
echo "${BLUE_CORE_DOCKER_ORG}/blue-agent-agentic_employer${BLUE_BUILD_IMG_SUFFIX}:v${BLUE_DEPLOY_VERSION}"
echo "plaforms: ${BLUE_BUILD_PLATFORM}"

# build docker
docker buildx build  --platform ${BLUE_BUILD_PLATFORM} ${BLUE_BUILD_CACHE_ARG} --build-arg BLUE_DEPLOY_VERSION --build-arg BLUE_BUILD_CACHE_ARG --build-ARG BLUE_BUILD_LIB_ARG
ARG BLUE_DEPLOY_VERSION
ENV BLUE_DEPLOY_VERSION=${BLUE_DEPLOY_VERSION} ${BLUE_BUILD_PUBLISH} -t ${BLUE_DEV_DOCKER_ORG}/blue-agent-agentic_employer${BLUE_BUILD_IMG_SUFFIX}:v${BLUE_DEPLOY_VERSION} -f Dockerfile.agent .

echo 'Done...'
