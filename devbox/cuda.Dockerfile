FROM ghcr.io/hienduyph/devbox:f41-1.0.0

RUN sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo \
  && sudo dnf module disable nvidia-driver -y \
  && sudo dnf --setopt=install_weak_deps=False -y install cuda-12-4

RUN dnf --setopt=install_weak_deps=False install -y https://github.com/coder/code-server/releases/download/v4.92.2/code-server-4.92.2-amd64.rpm hostname localectl
