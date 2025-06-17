#!/bin/bash
set -e

SCRIPT_DIR="src/main/resources/db/postgres"
chmod +x $SCRIPT_DIR/runMigration.sh

echo "🚀 Building project with Gradle..."
./gradlew clean build

echo "🐳 Starting PostgreSQL container..."
docker-compose -f docker/dev.yml up -d postgres

echo "⏳ Waiting for PostgreSQL to be ready..."
until docker exec $(docker ps -qf "name=postgres") pg_isready -U postgres > /dev/null 2>&1; do
  sleep 1
done
echo "✅ PostgreSQL is ready."

echo "📦 Running DB migration..."
sleep 5
cd "$SCRIPT_DIR"
./runMigration.sh
cd - > /dev/null

echo "🧩 Starting full application stack..."
docker-compose -f docker/dev.yml up --build