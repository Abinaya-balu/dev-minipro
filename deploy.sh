#!/bin/bash

# Set environment variables
IMAGE_NAME="abinayabalusamy/reactbooking"
CONTAINER_NAME="my-app"
REGISTRY="docker.io/abinayabalusamy"
PORT=5000  # Change if needed

echo "Starting deployment..."

# Stop and remove the existing container if it's running
echo "Stopping and removing existing container (if any)..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

# Pull the latest image
echo "Pulling latest image from registry..."
docker pull $REGISTRY/$IMAGE_NAME:latest

# Run the container
echo "Running new container..."
docker run -d --name $CONTAINER_NAME -p $PORT:5000 $REGISTRY/$IMAGE_NAME:latest

echo "Deployment complete! The application is running on port $PORT."
