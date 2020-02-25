#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

export CHANGE_MINIKUBE_NONE_USER=true

apt-get update -y
apt-get install -y apt-transport-https docker.io
apt-get upgrade -y

systemctl start docker
systemctl enable docker

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update -y
apt-get install -y kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
cp minikube /usr/local/bin && rm minikube

minikube start --vm-driver=none

mkdir -p /mnt/data/postgres
mkdir -p /mnt/data/strapi

kubectl apply -f https://raw.githubusercontent.com/MinePlugins/minikube/master/dreamteam.yaml
