# 1️⃣ Build React frontend
FROM node:18 AS frontend-builder
WORKDIR /app
COPY build/client/package.json build/client/package-lock.json ./
RUN npm install
COPY build/client ./
RUN npm run build

# 2️⃣ Setup Node.js backend
FROM node:18 AS backend
WORKDIR /app
COPY build/server/package.json build/server/package-lock.json ./
RUN npm install
COPY build/server ./
COPY --from=frontend-builder /app/build /app/build/client  # Copy React build

# Install PM2 to run both services
RUN npm install -g pm2

# 3️⃣ Final Image to Run App
FROM node:18
WORKDIR /app
COPY --from=backend /app /app
EXPOSE 5000 3000
CMD ["pm2-runtime", "server/app.js"]
