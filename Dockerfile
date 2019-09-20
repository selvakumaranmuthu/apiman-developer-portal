FROM node:10.16.2-alpine as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
#copy the rest of the project into the image
COPY . .

RUN npm run build

# Stage 2
FROM nginx:1.13.12-alpine

COPY --from=node /usr/src/app/dist/apiman-dev-portal /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

