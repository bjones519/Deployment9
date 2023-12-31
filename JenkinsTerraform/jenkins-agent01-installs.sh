#!/bin/bash

#################### Install Java ####################
sudo apt-get update -y
sudo apt-get install -y default-jre
sudo apt-get update -y

#################### Set up Docker's apt repository ####################

#################### Add Docker's official GPG key ####################
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#################### Add the repository to Apt sources ####################
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

#################### Install the Docker packages  ####################
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#################### Verify that the Docker Engine installation is successful by running the hello-world image ####################
sudo docker run hello-world

#################### Python dependencies#################
sudo apt update
sudo apt install -y software-properties-common 
sudo add-apt-repository -y ppa:deadsnakes/ppa 
sudo apt install -y python3.7 

#################### Done! ####################
echo "Installations successfully installed!"

exit 0
