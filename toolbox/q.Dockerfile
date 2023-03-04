FROM registry.fedoraproject.org/fedora-toolbox:37

RUN sudo dnf update -y && sudo dnf install curl -y

RUN sudo dnf groupinstall "Development Tools" -y \
  && sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

COPY ./platform/linux/fedora/pkgs/cli.txt /tmp/cli.txt
RUN sudo dnf install -y $(< /tmp/cli.txt)
