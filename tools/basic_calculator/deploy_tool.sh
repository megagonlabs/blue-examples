#/bin/bash

# USAGE: deploy_tool --target localhost|swarm --platform platform --port_mapping port_mapping --tool tool --image image --properties properties 
# if no arguments, use env variable as default

echo "here"
while [[ $# -gt 0 ]]; do
  case $1 in
    -t|--target)
      BLUE_DEPLOY_TARGET="$2"
      # pass argument and value
      shift 
      shift 
      ;;
    -p|--platform)
      BLUE_DEPLOY_PLATFORM="$2"
      # pass argument and value
      shift 
      shift 
      ;;
    -m|--port_mapping)
      PORT_MAPPING="$2"
      # pass argument and value
      shift 
      shift 
      ;;
    -r|--tool)
      TOOL="$2"
      # pass argument and value
      shift 
      shift 
      ;;
    -i|--image)
      IMAGE="$2"
      # pass argument and value
      shift 
      shift 
      ;;
    --properties)
      PROPERTIES="$2"
      # pass argument and value
      shift 
      shift 
      ;;
  esac
done

echo "there"
# set target to local, if not provided
if [ -z "$BLUE_DEPLOY_TARGET" ]
then
   export BLUE_DEPLOY_TARGET=local
fi

# set platform to default, if not provided
if [ -z "$BLUE_DEPLOY_PLATFORM" ]
then
   export BLUE_DEPLOY_PLATFORM=default
fi

# set properties to {}, if not provided
if [ -z "$PROPERTIES" ]
then
   export PROPERTIES='{}'
fi

export IMAGE=${IMAGE}
export TOOL=${TOOL}
export TOOL_LOWERCASE=$(echo ${TOOL}| tr '[:upper:]' '[:lower:]')
export PORT_MAPPING=${PORT_MAPPING}
export PROPERTIES=${PROPERTIES}
export IMAGE=${IMAGE}

echo "DEPLOY TARGET   = ${BLUE_DEPLOY_TARGET}"
echo "DEPLOY PLATFORM = ${BLUE_DEPLOY_PLATFORM}"
echo "TOOL = ${TOOL}"
echo "IMAGE = ${IMAGE}"
echo "PROPERTIES = ${PROPERTIES}"
echo "PORT_MAPPING = ${PORT_MAPPING}"

if [ $BLUE_DEPLOY_TARGET == swarm ]
then
   echo "Deploying to swarm..."
   envsubst < ${BLUE_INSTALL_DIR}/tools/basic_calculator/docker-compose-swarm-tool-template.yaml > ${BLUE_INSTALL_DIR}/tools/basic_calculator/docker-compose-swarm-tool-${BLUE_DEPLOY_PLATFORM}-${TOOL}.yaml
   docker stack deploy -c ${BLUE_INSTALL_DIR}/tools/basic_calculator/docker-compose-swarm-tool-${BLUE_DEPLOY_PLATFORM}-${TOOL}.yaml blue_tool_${BLUE_DEPLOY_PLATFORM}
elif [ $BLUE_DEPLOY_TARGET == localhost ]
then
   echo "Deploying to localhost..."
   envsubst < ${BLUE_INSTALL_DIR}/tools/basic_calculator/docker-compose-localhost-tool-template.yaml > ${BLUE_INSTALL_DIR}/tools/basic_calculator/docker-compose-localhost-tool-${BLUE_DEPLOY_PLATFORM}-${TOOL}.yaml
   docker compose --project-directory ${BLUE_INSTALL_DIR}/tools/basic_calculator -f ${BLUE_INSTALL_DIR}/tools/basic_calculator/docker-compose-localhost-tool-${BLUE_DEPLOY_PLATFORM}-${TOOL}.yaml -p blue_tool_${BLUE_DEPLOY_PLATFORM} up -d
fi


