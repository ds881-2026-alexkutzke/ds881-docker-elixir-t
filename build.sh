docker build -f henrique.dockerfile -t calcElixir . && \
docker run -d --name contElixir -p 8080:8080 calcElixir