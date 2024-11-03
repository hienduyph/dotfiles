FROM ghcr.io/hienduyph/devbox:f41-1.0.0

ENV VERSION=4.93.1
RUN dnf --setopt=install_weak_deps=False install -y https://github.com/coder/code-server/releases/download/v${VERSION}/code-server-${VERSION}-amd64.rpm hostname localectl

