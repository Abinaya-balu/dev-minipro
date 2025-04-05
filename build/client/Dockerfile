# Use Node.js to build the React app
FROM node:18-bullseye AS build
WORKDIR /app

# Copy package files first for caching
COPY package.json package-lock.json ./

RUN npm install

# Copy everything else
COPY . .  

# Build the project
RUN npm run build

# Use Nginx to serve the built React app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
