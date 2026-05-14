#!/bin/bash

echo "Building Docker image..."
docker build -t muchtodo_backend:latest .

echo "Docker image built successfully!"
docker images | grep muchtodo
