# Minikube ESTIAM

Installation automatiser de minikube sur ubuntu avec deploiment de 3 pods Vue -> Strapi -> PostgreSQL

## Getting Started

Ces instructions vous permettront d'obtenir une copie du projet sur votre ordinateur local à des fins de développement et de test. Voir déploiement pour des notes sur la façon de déployer le projet sur un système actif.

### Prerequisites

```
Ubuntu Server
Un user sudo
```

### Disclaimer

/!\ Attention /!\ Tous les fichier de config sont configurer pour fonctionner sur l'ip 178.32.215.77 !

### Installing minikube

Executer les commandes avec un utilisateur sudoer

```
curl https://raw.githubusercontent.com/MinePlugins/minikube/master/install-minikube.sh | sudo bash
```

### Installing namespaces, volumes, pods and services

Executer les commandes avec un utilisateur qui à accès à ```kubectl```

```
curl https://raw.githubusercontent.com/MinePlugins/minikube/master/minikube-pods.sh | sudo bash
```

### Installing kubernetes dashboard

Executer les commandes avec un utilisateur qui à accès à ```kubectl```

```
curl https://raw.githubusercontent.com/MinePlugins/minikube/master/minikube-dashboard.sh | sudo bash
```

## Running the tests

Voir si tous vas bien

```
kubectl get pods
```

## Built With

* [Minikube](https://kubernetes.io/fr/docs/tasks/tools/install-minikube/) - Minikube lightweight k8s installation
* [Kubernetes](https://kubernetes.io/) - Hypervisor, ochestrator
* [Ubuntu](https://ubuntu.com/download) - OS
ithub.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License
