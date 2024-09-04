FROM docker.io/fedora:40

COPY ./platform/linux/fedora/ /tmp/f

RUN sudo dnf update -y \
  && sudo /bin/bash /tmp/f/repo.sh \
  && sudo dnf update -y \
  && sudo dnf install -y $(< /tmp/f/pkgs/term.txt) \
  && sudo dnf install podman-remote podman-compose --exclude podman -y \
  && rm -rf /tmp/f
