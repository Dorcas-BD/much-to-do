# MuchToDo API - Container

A Golang REST API with MongoDB, containerized with Docker and deployed to Kubernetes using Kind.

## Prerequisites

- Docker
- Docker Compose
- Kind
- kubectl

## Project Structure

    .
    ├── Dockerfile
    ├── docker-compose.yml
    ├── .dockerignore
    ├── kubernetes/
    │   ├── namespace.yaml
    │   ├── mongodb/
    │   │   ├── mongodb-secret.yaml
    │   │   ├── mongodb-configmap.yaml
    │   │   ├── mongodb-pvc.yaml
    │   │   ├── mongodb-deployment.yaml
    │   │   └── mongodb-service.yaml
    │   └── backend/
    │       ├── backend-secret.yaml
    │       ├── backend-configmap.yaml
    │       ├── backend-deployment.yaml
    │       └── backend-service.yaml
    ├── scripts/
    │   ├── docker-build.sh
    │   ├── docker-run.sh
    │   ├── k8s-deploy.sh
    │   └── k8s-cleanup.sh
    └── evidence/

## Phase 1 - Docker Setup

### Build the Docker image

    ./scripts/docker-build.sh

### Run with Docker Compose

    ./scripts/docker-run.sh

### Test the application

    curl http://localhost:8080/ping

Expected response:

    {"message":"pong"}

## Phase 2 - Kubernetes Setup

### Install Kind and kubectl

    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind

### Create Kind cluster

    kind create cluster --name much-todo

### Load images into cluster

    kind load docker-image mongo:7 --name much-todo
    kind load docker-image muchtodo_backend:latest --name much-todo

### Deploy to Kubernetes

    ./scripts/k8s-deploy.sh

### Test via NodePort

    curl http://172.21.0.2:30080/ping

### Test via Ingress

Add this to your hosts file first:

    echo "172.21.0.2 much-todo.local" | sudo tee -a /etc/hosts

Then test:

    curl http://much-todo.local/ping

### Clean up

    ./scripts/k8s-cleanup.sh

## Environment Variables

| Variable | Description |
|----------|-------------|
| PORT | Application port (default: 8080) |
| MONGO_URI | MongoDB connection string |
| DB_NAME | Database name |
| JWT_SECRET_KEY | JWT signing key |
| JWT_EXPIRATION_HOURS | JWT token expiry in hours |
| LOG_LEVEL | Logging level DEBUG or INFO |
| LOG_FORMAT | Log format json or text |
| ENABLE_CACHE | Enable Redis caching true or false |
