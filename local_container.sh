PROJECT_NAME=msc-2023
# Julia Algorithimic Trading Optimal Control

# Windows OS

# Build Image
# docker build  -t ${PROJECT_NAME}-image  . 

# Remove container with same name
# docker rm ${PROJECT_NAME}-container 

# Start container
winpty docker run --rm -it \
--env-file .env \
--mount type=bind,source="$(PWD)",target=/root/project \
--name ${PROJECT_NAME}-container \
-p 8080:8080 \
--entrypoint bash \
${PROJECT_NAME}-image 

# Enter running container
# winpty docker exec -it ${PROJECT_NAME}-container bash

