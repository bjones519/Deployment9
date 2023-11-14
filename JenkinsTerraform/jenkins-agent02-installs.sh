#!/bin/bash

#################### Install Java: ####################
sudo apt-get update -y
sudo apt-get install -y default-jre
sudo apt-get update -y

#################### Install kubectl: ####################

#################### Update the apt package index and install packages needed to use the Kubernetes apt repository ####################
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl

#################### Download the public signing key for the Kubernetes package repositories ####################

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

#################### Add the appropriate Kubernetes apt repository ####################
#################### This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list ####################
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

#################### Update apt package index, then install kubectl: ####################
sudo apt-get update
sudo snap install kubectl
sudo apt-get install -y kubectl

#################### Ensure the version you installed is up-to-date: ####################
kubectl version --client

#################### Installation complete ####################
echo "-----------------------kubectl successfully installed!-----------------------"




##########################Come back to separate files##########################

# #!/bin/bash

# #################### Install Java ####################
# sudo apt-get update -y
# sudo apt install -y default-jre
# sudo apt-get update -y

# #################### Install Terraform ####################
# sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# #################### Install the HashiCorp GPG key  ####################
# wget -O- https://apt.releases.hashicorp.com/gpg | \
# gpg --dearmor | \
# sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg


# #################### Verify the key's fingerprint ####################
# gpg --no-default-keyring \
# --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
# --fingerprint

# #################### Add the official HashiCorp repository to your system ####################
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
# https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
# sudo tee /etc/apt/sources.list.d/hashicorp.list

# #################### Download the package information from HashiCorp ####################
# sudo apt update

# #################### Install Terraform from the new repository ####################
# sudo apt-get install -y terraform

# #################### Verify the installation ####################
# terraform -help

# #################### Done! ####################
# echo "Installations successfully installed!"

# exit 0
