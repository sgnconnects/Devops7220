# Docker CMDs

## docker build
docker build -t <docker_hub_username>/devops7220-scraper ./scraper

## docker run
### detached mode
docker run -dt --name devops7220-scraper <docker_hub_username>/devops7220-scraper
### attached mode
docker run -it --name devops7220-scraper <docker_hub_username>/devops7220-scraper sh

## docker push
docker push <docker_hub_username>/devops7220-scraper

## docker log
docker logs devops7220-scraper

## system prune
docker system prune -a -f