# Use a Node.js base image
FROM node:18-alpine AS build-stage

# Set the working directory
WORKDIR /app

# Copy the package.json files and install dependencies
COPY server/package.json server/package-lock.json ./server/
COPY client/package.json client/package-lock.json ./client/

# Install dependencies for both server and client
RUN cd server && npm install
RUN cd client && npm install && npm run build

# Use a lightweight Node.js image for production
FROM node:18-alpine AS production-stage

WORKDIR /app

# Copy built client files and server files
COPY --from=build-stage /app/server /app/server
COPY --from=build-stage /app/client/build /app/server/public

# Set environment variables
ENV NODE_ENV=production

# Expose the necessary port
EXPOSE 5000

# Start the server
CMD ["node", "server/app.js"]
