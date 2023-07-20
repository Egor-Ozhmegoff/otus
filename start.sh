docker stack rm otus
docker image rm otus/ubuntu
docker-compose build
docker stack deploy --compose-file docker-compose.yaml otus