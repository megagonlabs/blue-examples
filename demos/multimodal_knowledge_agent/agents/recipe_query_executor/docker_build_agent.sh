#!/bin/bash
echo 'Building docker image...'
echo "${BLUE_CORE_DOCKER_ORG}/blue-agent-recipe_query_executor${BLUE_BUILD_IMG_SUFFIX}:v${BLUE_DEPLOY_VERSION}"
echo "plaforms: ${BLUE_BUILD_PLATFORM}"

# build docker (adding build context for data files)
docker buildx build  --platform ${BLUE_BUILD_PLATFORM} ${BLUE_BUILD_CACHE_ARG} --build-arg BLUE_DEPLOY_VERSION --build-arg BLUE_BUILD_CACHE_ARG --build-arg BLUE_BUILD_LIB_ARG ${BLUE_BUILD_PUBLISH} -t ${BLUE_DEV_DOCKER_ORG}/blue-agent-recipe_query_executor${BLUE_BUILD_IMG_SUFFIX}:v${BLUE_DEPLOY_VERSION} -f Dockerfile.agent --build-context data=../../data .

echo 'Done...'