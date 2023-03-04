FROM registry.fedoraproject.org/fedora-toolbox:37

RUN sudo dnf update -y && sudo dnf install curl -y

RUN sudo dnf groupinstall "Development Tools" -y \
  && sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

COPY ./platform/linux/fedora/ /tmp/f
RUN sudo /bin/bash /tmp/f/repo.sh \
  && sudo dnf install -y $(< /tmp/f/pkgs/cli.txt)

