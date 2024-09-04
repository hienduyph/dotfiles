FROM ghcr.io/hienduyph/devbox:f40-1.0.0

RUN sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo \
  && sudo dnf module disable nvidia-driver -y \
  && sudo dnf -y install cuda-12-4
