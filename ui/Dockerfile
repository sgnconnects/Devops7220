FROM node:alpine3.11

ARG REACT_APP_API_HOST=http://localhost:5000
ARG HOST=0.0.0.0
ARG PORT=3000

# ENV SKIP_PREFLIGHT_CHECK=true
ENV HOST=$HOST
ENV PORT=$PORT
ENV REACT_APP_API_HOST=$REACT_APP_API_HOST

WORKDIR /app
COPY /client .
EXPOSE 3000
RUN yarn install
CMD yarn start

# RUN npm install
# CMD npm start

# FROM mhart/alpine-node:11 AS builder
# WORKDIR /app
# COPY /client .
# RUN npm install react-scripts -g --silent
# RUN yarn install
# RUN yarn run build

# FROM mhart/alpine-node
# RUN yarn global add serve
# WORKDIR /app
# COPY --from=builder /app/build .
# CMD ["serve", "-p", "80", "-s", "."]doc