#!/bin/bash

set -e

echo "Setting Nameserver"

sudo tee /etc/resolvconf/resolv.conf.d/head << END
nameserver 127.0.0.1
END

sudo rm -f /etc/resolv.conf
sudo ln -s /run/resolvconf/resolv.conf /etc
