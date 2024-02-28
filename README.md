# PER2023–045 - Type : Développement
## Déploiement, monitoring et optimisation de performances d'une pile technologique de Micro services, sur Kafka, Kubernetes, GCP

### Authors of this repository
- [Antoine BUQUET](https://github.com/antoinebqt)
- [Benoit GAUDET](https://github.com/BenoitGAUDET38)
- [Ayoub IMAMI](https://github.com/AyoubIMAMI)
- [Mourad KARRAKCHOU](https://github.com/MouradKarrakchou)

---

### Requirements
- 16 CPU
- 16 GB RAM
- Docker
- Kubernetes
- Kafka
- Ansible

---

### Project structure
- [ansible](https://github.com/antoinebqt/TER/tree/master/ansible) folder which contains the `.yaml` files to automatically deploy the the application, the Kafka cluster, Prometheus and Grafana
- [kubernetes](https://github.com/antoinebqt/TER/tree/master/kubernetes) folder which contains the `.yaml` files to deploy all of the kubernetes ressources
- [scripts](https://github.com/antoinebqt/TER/tree/master/scripts) contains `.sh` files using Ansible commands:
  - `requirements1.sh`: install Docker
  - `requirements2.sh`: install Kubectl, Minikube, Helm, Python packages and Ansible
  - `deployAll.sh`: deploy the application, Kafka, Prometheus and Grafana
  - `cleanCluster.sh`: delete kubernetes ressources
  - `uninstall.sh`: delete kubernetes ressources and uninstall Docker, Kubectl, Minikube, Helm, Python packages and Ansible
  - `deployApp.sh`, `deployKafka.sh`, `deployPrometheus.sh` allow to deploy each element separately

---
 
### First configuration on a clean machine
You must be in the root folder to use the scripts.

- Execute the following command in ordrer to be able to **execute all the scripts**
```bash
chmod +x scripts/chmodAll.sh && scripts/chmodAll.sh
```
- Install Docker
```bash
scripts/mnk-requirements1.sh
```
- Once the previous script is done, **exit** the machine and **reconnect** to it in order to update the Docker users group, thus avoiding using the `sudo su` command everytime
- Install Kubectl, Minikube, Helm, Python packages and Ansible
```bash
scripts/mnk-requirements2.sh
```
- **Deploy** all the ressources
```bash
scripts/deployEnv.sh
```

---

### Cleaning & Uninstalling
- If you only want to **delete the kubernetes ressources**, just execute the following command:
```bash
scripts/cleanCluster.sh
```
- But if you want to completely **uninstall** the tools used for this project, use the following command. It will delete kubernetes ressources and uninstall Docker, Kubectl, Minikube, Helm, Python packages and Ansible
```bash
scripts/uninstall.sh
```

### Configuration with Grid5000
- All information about Grid5000 can be found on [getting started](https://www.grid5000.fr/w/Getting_Started)
- Clone the project on your home directory on a site of Grid5000 (for exemple **sophia**)
- Get the number of hosts that you want for the k8s cluster
```bash
# Exmple of 2 nodes for 2 hours
oarsub -I -l host=2,walltime=2 -t deploy
kadeploy3 debian11-min
```
- Clone this project in your Grid5000 home directory
```bash
git clone https://github.com/antoinebqt/PER2023-045.git
```
- Modify the IP addresses in k3s/hosts.ini (only one master allowed)
```bash
cd PER2023-045
./g5k-scripts/deploy-k3s-cluster.sh
```
- Connect to your master node with :
```bash
ssh root@ip_address
ssh root@grid_node_name
```
- Deploy the stack :
```bash
cd ~/PER2023-045
./scripts/deployEnv.sh
```
- Wait 10 minutes then launch the experience
```bash
./scripts/launchExperience
```
- Wait until the end of the experience
- Retrieve the experience data
```bash
# from your home Grid5000, not the master node
scp -r root@ip/name:~/PER2023-045/input ~
```
