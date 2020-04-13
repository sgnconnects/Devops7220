#FROM node:10.20.0-stretch
FROM node:lts-alpine3.9
WORKDIR /usr/src/app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["npm" , "start"]