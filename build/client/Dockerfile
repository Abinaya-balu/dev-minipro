# Use Node.js image to build the React app
FROM node:18-bullseye AS build
WORKDIR /app

# Copy package.json and package-lock.json first for caching
COPY build/client/package.json build/client/package-lock.json ./

# Install dependencies
RUN npm install

# Copy the entire client project
COPY build/client ./

# Build the React app
RUN npm run build

# Use Nginx to serve the built React app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

