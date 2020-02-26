#!/bin/bash

mkdir -p /mnt/data/postgres

kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/namespaces.yaml
kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/volumes.yaml
kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/deployments.yaml
kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/services.yaml
