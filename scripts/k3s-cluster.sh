export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook k3s/deploy-cluster-kube.yaml -i k3s/hosts.ini