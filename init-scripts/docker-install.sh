#!/usr/bin/env bash

sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $USER
sudo docker run -d -p 5000:5000 -v /home/ubuntu/database.config:/database.config zainmahmood/group4:v1

# ls -la /home/ubuntu
# sudo docker pull zainmahmood/group4:latest
# sudo docker run -p 8080:8080 -v /home/ubuntu/log:/log zainmahmood/group4:0.1