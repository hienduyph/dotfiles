# Development in containers with distrobox

```bash
mkdir -p ~/.config/systemd/user
```

```bash
tee ~/.config/systemd/user/code-server.service <<EOF
[Unit]
Description=Start Code Server

[Service]
Type=simple
ExecStart=-bash -c "distrobox enter q -- code-server"
Restart=on-failure
RestartSec=1s
RemainAfterExit=yes

[Install]
WantedBy=default.target
EOF
```

