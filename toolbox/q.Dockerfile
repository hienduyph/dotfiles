FROM registry.fedoraproject.org/fedora-toolbox:40

COPY ./platform/linux/fedora/ /tmp/f

RUN sudo dnf update -y \
  && sudo /bin/bash /tmp/f/repo.sh \
  && sudo dnf update -y \
  && sudo dnf install curl jq -y \
  && export CODE_VERSION="$(curl -s "https://api.github.com/repos/coder/code-server/releases" | jq -r 'first | .tag_name')" \
  && export CODE_VERSION="${CODE_VERSION#v}" \
  && sudo dnf install -y https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server-${CODE_VERSION}-amd64.rpm \
  && sudo dnf install -y podman-remote podman-compose \
  && sudo dnf groupinstall "Development Tools" -y \
  && sudo dnf install -y $(< /tmp/f/pkgs/term.txt)
