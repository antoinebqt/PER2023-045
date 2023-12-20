# CLEAN KUBERNETES CLUSTER
printf "\n\033[1;36m## Cleaning Kubernetes Cluster\033[0m\n"
./scripts/cleanCluster.sh

# DOCKER
printf "\n\033[1;36m## Uninstalling Docker\033[0m\n"
sudo apt remove --purge -y docker-ce docker-ce-cli containerd.io
sudo rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
sudo rm /etc/apt/sources.list.d/docker.list

# KUBECTL
printf "\n\033[1;36m## Uninstalling Kubectl\033[0m\n"
sudo rm /usr/local/bin/kubectl

# MINIKUBE
printf "\n\033[1;36m## Uninstalling Minikube\033[0m\n"
sudo rm /usr/local/bin/minikube

# HELM
printf "\n\033[1;36m## Uninstalling Helm\033[0m\n"
sudo rm get_helm.sh
sudo rm -rf /usr/local/bin/helm

# ANSIBLE
printf "\n\033[1;36m## Uninstalling Ansible\033[0m\n"
sudo apt remove --purge -y ansible

# Nettoyer les dépendances non utilisées
sudo apt autoremove -y
