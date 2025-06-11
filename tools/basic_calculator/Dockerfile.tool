FROM --platform=$BUILDPLATFORM python:3.10
ARG BLUE_BUILD_CACHE_ARG
ARG BLUE_BUILD_LIB_ARG

# Set workdir
WORKDIR /app

# Build requirements first
ADD src/requirements.core /app/requirements.core
RUN pip install ${BLUE_BUILD_CACHE_ARG} ${BLUE_BUILD_LIB_ARG} -r requirements.core

ADD src/requirements.tool /app/requirements.tool
RUN pip install ${BLUE_BUILD_CACHE_ARG} -r requirements.tool

ADD src/requirements.basic_calculator_tool /app/requirements.basic_calculator_tool
RUN pip install ${BLUE_BUILD_CACHE_ARG} -r requirements.basic_calculator_tool

# Copy service files
ADD /src /app/

ENTRYPOINT ["python", "basic_calculator_tool.py" ] 
