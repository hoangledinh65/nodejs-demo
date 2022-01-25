FROM node:latest
COPY app.js /demo/app.js
WORKDIR /demo
CMD [ "node", "app.js", "&" ]