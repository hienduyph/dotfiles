FROM registry.fedoraproject.org/fedora-toolbox:40

COPY ./platform/linux/fedora/ /tmp/f

RUN sudo dnf update -y \
  && sudo /bin/bash /tmp/f/repo.sh \
  && sudo dnf install curl podman podman-compose docker-ce-cli docker-buildx-plugin docker-compose-plugin -y \
  && sudo dnf install https://github.com/coder/code-server/releases/download/v4.92.2/code-server-4.92.2-amd64.rpm \
  && sudo dnf groupinstall "Development Tools" -y \
  && sudo dnf install -y $(< /tmp/f/pkgs/term.txt) \
  && sudo dnf install -y $(< /tmp/f/pkgs/appdev.txt) \
  && curl -LsSf https://astral.sh/uv/install.sh | sh
