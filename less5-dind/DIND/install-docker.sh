#!/bin/bash


# https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_20.10.6~3-0~debian-buster_amd64.deb

# requirements
apt update & apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# add repo
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list 
apt update

# install docker
apt-get install docker-ce docker-ce-cli containerd.io

