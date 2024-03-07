# Stage 1: Build the Vue.js application
FROM node:lts AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Setup the production image using Nginx to serve the SPA
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 777
CMD ["nginx", "-g", "daemon off;"]
