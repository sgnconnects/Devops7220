# Docker CMDs

## docker build
docker build -t <dockerhub_username>/devops7220-api ./api

## docker run
### detached mode
docker run -dt -p 5000:5000 --env MONGODB_USR=<mongodb_username> --env MONGODB_PWD=<mongodb_password> --name devops7220-api <dockerhub_username>/devops7220-api
### attached mode
docker run -it -p 5000:5000 --env MONGODB_USR=<mongodb_username> --env MONGODB_PWD=<mongodb_password> --name devops7220-api <dockerhub_username>/devops7220-api sh

## docker push
docker push <dockerhub_username>/devops7220-api

## docker log
docker logs devops7220-api

## system prune
docker system prune -a -f

## Running the app localy
export MONGODB_USR=<mongodb_username> 
export MONGODB_PWD=<mongodb_password>
python3 backend.py
