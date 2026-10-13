# =========================================
# Stage 1: Build the React.js Application
# =========================================
# Use Node 22, as required by the README and the "engines" field in package.json
FROM node:22-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
RUN npm run build

# =========================================
# Stage 2: Prepare Nginx to Serve Static Files
# =========================================
FROM nginx:alpine
COPY --from=builder /app/dist /app
COPY nginx/nginx.conf /etc/nginx/nginx.conf
# Documents that the container listens on port 80 (matches "listen 80" in nginx.conf)
EXPOSE 80