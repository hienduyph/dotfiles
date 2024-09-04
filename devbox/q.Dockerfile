FROM docker.io/fedora:40

COPY ./platform/linux/fedora/ /tmp/f

RUN sudo dnf update -y \
  && sudo /bin/bash /tmp/f/repo.sh \
  && sudo dnf --setopt=install_weak_deps=False install -y which \
  && sudo dnf --setopt=install_weak_deps=False install -y $(< /tmp/f/pkgs/term.txt) \
  && sudo dnf --setopt=install_weak_deps=False install podman-remote -y \
  && sudo python3 -m pip install podman-compose \
  && rm -rf /tmp/f
