#!/bin/bash
# Run integration tests with Docker Compose

set -e

echo "🐳 Starting test infrastructure..."
docker compose -f docker-compose.test.yaml up -d postgres-test redis-test opa-test

echo "⏳ Waiting for services to be healthy..."
sleep 10

echo "🧪 Running integration tests..."
docker compose -f docker-compose.test.yaml run --rm integration-tests

echo "🧹 Cleaning up..."
docker compose -f docker-compose.test.yaml down -v

echo "✅ Integration tests complete!"

