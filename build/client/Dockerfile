@@ -1,16 +1,16 @@
 # Use Node.js image to build the React app
 FROM --platform=linux/amd64 node:18-alpine AS build
 FROM node:18-bullseye AS build
 WORKDIR /app
 
 COPY package.json package-lock.json ./
 RUN npm install
 
 COPY . .
 RUN npm run build
 
 # Use Nginx to serve the built React app
 FROM nginx:alpine
 COPY --from=build /app/build /usr/share/nginx/html
 
 EXPOSE 80
 CMD ["nginx", "-g", "daemon off;"]
