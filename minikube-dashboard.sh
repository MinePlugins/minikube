#!/bin/bash

# Si on voulais mettre un custom certificates pour let's encrypt par exemple
mkdir -p $HOME/certs
openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out $HOME/certs/tls.crt -keyout $HOME/certs/tls.key -subj "/C=FR/ST=Paris/L=Paris/O=Global Security/OU=IT Department/CN=exemple.com"
kubectl create namespace kubernetes-dashboard
kubectl create secret generic kubernetes-dashboard-certs --from-file=$HOME/certs -n kubernetes-dashboard

# Création du dashboard
kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/dashboard.yaml

# Générer et afficher le token de login
echo "Utiliser ce token d'accès : "
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'
