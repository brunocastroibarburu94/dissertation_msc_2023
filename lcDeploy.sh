PROJECT_NAME=jupyjul

winpty docker run --rm \
--mount type=bind,source="$(PWD)",target=/root/project \
--name ${PROJECT_NAME}-container \
-p 8080:8080 \
${PROJECT_NAME}-image
