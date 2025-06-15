#!/bin/bash
set -e

echo "Building project with Gradle..."
./gradlew clean build

echo "Bringing up Docker containers for AnaBakes development environment..."
docker-compose -f docker/dev.yml up --build
