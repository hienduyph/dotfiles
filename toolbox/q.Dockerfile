FROM registry.fedoraproject.org/fedora-toolbox:40

COPY ./platform/linux/fedora/ /tmp/f

RUN sudo dnf update -y \
  && sudo dnf install curl rust cargo podman podman-compose -y \
  && sudo dnf groupinstall "Development Tools" -y \
  && sudo /bin/bash /tmp/f/repo.sh \
  && sudo dnf install -y $(< /tmp/f/pkgs/term.txt) \
  && sudo dnf install -y $(< /tmp/f/pkgs/appdev.txt) \
  && cargo install despell && sudo mv ~/.cargo/bin/despell /usr/local/bin \
  && curl -LsSf https://astral.sh/uv/install.sh | sh
