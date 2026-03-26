docker build -f paulo.Dockerfile -t calcelixir . && \
docker run -d --name contEgitlixir -p 8080:8080 calcelixir