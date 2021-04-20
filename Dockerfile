FROM node:14-alpine as build

ENV HOME /usr/local/src
WORKDIR $HOME
COPY . $HOME

RUN npm install \
 && npx @11ty/eleventy


FROM nginx:stable-alpine

COPY --from=build /usr/local/src/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
