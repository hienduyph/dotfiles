#!/usr/bin/env bash

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#id2

curl -s -L https://nvidia.github.io/libnvidia-container/centos8/libnvidia-container.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo

sudo dnf install -y nvidia-container-toolkit 
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# sudo docker run --rm --runtime=nvidia --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
