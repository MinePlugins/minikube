#!/bin/bash

mkdir -p $HOME/certs
openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out $HOME/certs/tls.crt -keyout $HOME/certs/tls.key
kubectl create secret generic kubernetes-dashboard-certs --from-file=$HOME/certs -n kubernetes-dashboard
kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/dashboard.yaml
