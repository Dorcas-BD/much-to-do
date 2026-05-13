#!/bin/bash

echo "Starting containers with Docker Compose..."
docker-compose up -d

echo "Containers started!"
docker ps
