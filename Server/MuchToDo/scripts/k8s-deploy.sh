#!/bin/bash

echo "Loading images into Kind cluster..."
kind load docker-image mongo:7 --name much-todo
kind load docker-image muchtodo_backend:latest --name much-todo

echo "Deploying to Kubernetes..."
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml

echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=mongodb -n much-todo --timeout=120s
kubectl wait --for=condition=ready pod -l app=backend -n much-todo --timeout=120s

echo "Deployment complete!"
kubectl get all -n much-todo
