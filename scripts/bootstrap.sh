#!/bin/bash

su ubuntu

### Install Docker CE ###

# 1. Update the apt package index 
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 2. Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 3. Use the following command to set up the stable repository
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Install Docker Engine
sudo apt-get update
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

### Install KubeCtl ###

# 1. Download the latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# 2. Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

### Install MiniKube ###

# 1. Download Binary
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64

# 2. Install Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# 3. Start Kubernetes Cluster
sudo apt install conntrack
sudo minikube start --vm-driver=none