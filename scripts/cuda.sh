# Add NVIDIA package repositories
#!/bin/bash

set -e

_add_repo() {
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
  sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
  sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
  sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
  curl -Lo /tmp/ml.deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb
  sudo apt install /tmp/ml.deb
  sudo apt-get update
}


_cuda() {
  # Install development and runtime libraries (~4GB)
  sudo apt-get install --no-install-recommends \
    cuda-11-0 \
    libcudnn8  \
    libcudnn8-dev
}

_add_repo
_cuda
