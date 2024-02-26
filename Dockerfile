FROM node:lts-alpine as dependencies

RUN apk add --no-cache libc6-compat
WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:lts-alpine as runner
WORKDIR /usr/src/app
ENV NODE_ENV production
ENV PORT 3000
ENV HOST 0.0.0.0
EXPOSE 3000
RUN chown -R node:node .
USER node

COPY --from=dependencies /usr/src/app/dist ./dist

CMD [ "node", "dist/app/analog/server/index.mjs" ]