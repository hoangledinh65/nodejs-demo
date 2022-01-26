FROM node:latest
COPY app.js /demo/app.js
COPY package.json /demo/package.json
WORKDIR /demo
RUN npm install
EXPOSE 8080
CMD [ "node", "app.js"]