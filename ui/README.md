# Docker CMDs

## docker build
docker build -t <dockerhub_username>/devops7220-ui ./ui

## docker run
### detached mode
docker run -dt -p 3000:3000 --env REACT_APP_API_HOST=http://localhost:5000 --name devops7220-ui <dockerhub_username>/devops7220-ui
### attached mode
docker run -it -p 3000:3000 --env REACT_APP_API_HOST=http://localhost:5000 --name devops7220-ui <dockerhub_username>/devops7220-ui sh

## docker push
docker push <dockerhub_username>/devops7220-ui

## docker log
docker logs devops7220-ui

## system prune
docker system prune -a -f

## Running the app localy
cd client
npm install
export REACT_APP_API_HOST=http://localhost:5000/
npm start



        "@testing-library/jest-dom": "^4.2.4",
        "@testing-library/react": "^9.5.0",
        "@testing-library/user-event": "^7.2.1",
        "bootstrap": "^4.4.1",
        "three": "^0.115.0",