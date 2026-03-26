IMAGE_NAME="calc_elixir"
CONTAINER_NAME="container_elixir"
PORT=8080

docker build -f thiago.DockerFile -t ${IMAGE_NAME} .

docker rm -f ${CONTAINER_NAME} 2>/dev/null
docker run -d --name ${CONTAINER_NAME} -p ${PORT}:8080 ${IMAGE_NAME}