# PACKAGE PYTHON
printf "\n\033[1;36m## Installing Python packages\033[0m\n"
sudo apt update
sudo apt install -y python3-pip
sudo apt install -y python3-kubernetes

# ANSIBLE
printf "\n\033[1;36m## Installing Ansible\033[0m\n"
sudo apt install -y ansible

# KUBECTL
printf "\n\033[1;36m## Installing Kubectl\033[0m\n"
sudo apt install -y curl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# HELM
printf "\n\033[1;36m## Installing Helm\033[0m\n"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# SSHPASS
printf "\n\033[1;36m## Installing sshpass\033[0m\n"
sudo apt install -y sshpass
