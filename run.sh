#!/bin/bash

IMAGE_NAME=calculadora-elixir
CONTAINER_NAME=calculadora-container

docker build -f Felyppe.Dockerfile -t $IMAGE_NAME .

docker rm -f $CONTAINER_NAME 2>/dev/null true

docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_NAME

echo "container: $CONTAINER_NAME"
echo "porta: http://localhost:8080"