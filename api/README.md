# Docker CMDs

## docker build
docker build -t <docker_hub_username>/devops7220-api ./api

## docker run
### detached mode
docker run -dt -p 5000:5000 --name devops7220-api <docker_hub_username>/devops7220-api
### attached mode
docker run -it -p 5000:5000 --name devops7220-api <docker_hub_username>/devops7220-api sh

## docker push
docker push <docker_hub_username>/devops7220-api

## docker log
docker logs devops7220-api

## system prune
docker system prune -a -f

## Running the app localy
export MONGODB_USR=<mongodb_username> 
export MONGODB_PWD=<mongodb_password>
python3 backend.py