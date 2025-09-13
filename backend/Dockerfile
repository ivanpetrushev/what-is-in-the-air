# ---- Stage 1: Development ----
# This stage is used for local development with hot-reloading
FROM node:24-alpine AS development

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# This is mainly for initial setup; the volume mount will keep it in sync
COPY . .

EXPOSE 3000

CMD ["npm", "run", "start:dev"]


# ---- Stage 2: Build ----
FROM node:24-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
RUN npm prune --production


# ---- Stage 3: Production ----
FROM node:24-alpine AS production

ENV NODE_ENV=production
WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/main.js"]