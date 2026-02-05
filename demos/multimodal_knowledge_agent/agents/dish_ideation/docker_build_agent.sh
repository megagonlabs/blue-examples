#/bin/bash
echo 'Building docker image...'
echo "${BLUE_CORE_DOCKER_ORG}/blue-agent-dish_ideation${BLUE_BUILD_IMG_SUFFIX}:v${BLUE_DEPLOY_VERSION}"
echo "plaforms: ${BLUE_BUILD_PLATFORM}"

# Enable BuildKit for better caching
export DOCKER_BUILDKIT=1

# build docker with inline cache (compatible with --load)
docker buildx build \
  --platform ${BLUE_BUILD_PLATFORM} \
  ${BLUE_BUILD_CACHE_ARG} \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg BLUE_DEPLOY_VERSION \
  --build-arg BLUE_BUILD_CACHE_ARG \
  --build-arg BLUE_BUILD_LIB_ARG \
  ${BLUE_BUILD_PUBLISH} \
  -t ${BLUE_DEV_DOCKER_ORG}/blue-agent-dish_ideation${BLUE_BUILD_IMG_SUFFIX}:v${BLUE_DEPLOY_VERSION} \
  -f Dockerfile.agent .

echo 'Done...'
