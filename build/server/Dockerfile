# Use Node.js as the base image
FROM node:18-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

EXPOSE 5000
CMD ["node", "app.js"]
