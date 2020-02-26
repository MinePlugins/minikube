#!/bin/bash

kubectl create secret generic kubernetes-dashboard-certs --from-file=$HOME/certs -n kubernetes-dashboard
kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/dashboard.yaml
