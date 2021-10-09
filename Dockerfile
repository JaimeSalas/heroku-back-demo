FROM node:14-alpine AS base

WORKDIR /usr/app

# Build backend
FROM base AS build-backend
COPY ./ ./
RUN npm install
RUN npm run build

# Release
FROM base AS release

COPY --from=build-backend /usr/app/dist ./

COPY ./package.json ./
COPY ./package-lock.json ./

RUN npm ci --only=production

ENTRYPOINT [ "node", "index" ]
