# Stage 1: Build stage
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

# Stage 2: Run stage
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app .

COPY global-bundle.pem /app/certs/global-bundle.pem

CMD ["node", "server.js"]