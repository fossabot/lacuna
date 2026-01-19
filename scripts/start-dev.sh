#!/bin/bash
# Start local development environment

set -e

echo "🐳 Starting Lacuna development environment..."

# Start infrastructure
docker compose up -d postgres redis opa

echo "⏳ Waiting for services to be healthy..."
sleep 5

# Run migrations
echo "📦 Running database migrations..."
docker compose run --rm migrate

echo "🚀 Starting Lacuna API..."
docker compose up lacuna-api


