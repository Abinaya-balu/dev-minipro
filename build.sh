#!/bin/bash

set -e  # Exit script if any command fails

echo "🚀 Building React Client..."
cd build/client
npm install
npm run build
cd ../../

echo "📦 Installing Server Dependencies..."
cd build/server
npm install
cd ../../

echo "✅ Build Completed Successfully!"
