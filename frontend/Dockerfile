# ---- Stage 1: Development ----
# This stage is for local development with hot-reloading
FROM node:24-alpine AS development

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 5173

CMD ["npm", "run", "dev"]


# ---- Stage 2: Build ----
FROM node:24-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build


# ---- Stage 3: Production ----
# This stage serves the built assets using Nginx
FROM nginx:1.25-alpine AS production

COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

# Copy a custom nginx configuration to handle SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]