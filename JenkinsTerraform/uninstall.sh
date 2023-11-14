#!/bin/bash

#################### Uninstall kubectl: ####################
sudo apt-get remove --purge -y kubectl
sudo rm /etc/apt/sources.list.d/kubernetes.list
sudo apt-key --keyring /etc/apt/keyrings/kubernetes-apt-keyring.gpg del stable-v1.28
sudo apt-get update

#################### Uninstall Java: ####################
sudo apt-get remove --purge -y default-jre

#################### Clean up: ####################
sudo apt-get autoremove -y
sudo apt-get clean
