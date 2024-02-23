FROM node:lts-alpine

WORKDIR /home/node/
COPY dist/ /home/node/
USER node
EXPOSE 3000
CMD [ "node", "app/analog/server/index.mjs" ]