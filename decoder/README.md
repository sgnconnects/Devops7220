# Docker CMDs

## docker build
docker build -t <docker_hub_username>/devops7220-decoder ./decoder

## docker run
### detached mode
docker run -dt -p 3000:3000 --name devops7220-decoder <docker_hub_username>/devops7220-decoder
### attached mode
docker run -it -p 3000:3000 --name devops7220-decoder <docker_hub_username>/devops7220-decoder sh

## docker push
docker push <docker_hub_username>/devops7220-decoder

## docker log
docker logs devops7220-decoder

## system prune
docker system prune -a -f

## kill all containers
docker kill $(docker ps -aq)