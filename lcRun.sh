PROJECT_NAME=jupyjul

winpty docker run --rm -it \
--mount type=bind,source="$(PWD)",target=/root/project \
--name ${PROJECT_NAME}-container \
-p 8080:8080 \
--entrypoint bash \
${PROJECT_NAME}-image 
