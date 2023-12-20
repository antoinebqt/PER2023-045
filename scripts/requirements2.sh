# WARNING
printf "\n\033[1;31m## Note you had to reboot the system after requirements1.sh\033[0m\n"
sleep 5

# KUBECTL
printf "\n\033[1;36m## Installing Kubectl\033[0m\n"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# MINIKUBE
printf "\n\033[1;36m## Installing Minikube\033[0m\n"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo minikube start --force #--cpus=4 --memory=4g

# HELM
printf "\n\033[1;36m## Installing Helm\033[0m\n"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# PACKAGE PYTHON
printf "\n\033[1;36m## Installing Python packages\033[0m\n"
sudo apt install python3-pip
sudo apt install python3-kubernetes

# ANSIBLE
printf "\n\033[1;36m## Installing Ansible\033[0m\n"
sudo apt update
sudo apt install ansible