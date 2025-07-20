FROM ghcr.io/hienduyph/devbox:f42-1.0.0

ENV VERSION=4.102.1
RUN dnf install python3.11 python3.11-devel python3.12 python3.12-devel nodejs-npm clang-tools-extra -y \
  && dnf --setopt=install_weak_deps=False install -y https://github.com/coder/code-server/releases/download/v${VERSION}/code-server-${VERSION}-amd64.rpm hostname localectl
