#!/bin/bash

set -e

echo "Setting Nameserver"

sudo tee /etc/systemd/resolved.conf << END
[Resolve]
DNS=127.0.0.1
#FallbackDNS=
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=yes
#DNSStubListener=yes
#ReadEtcHosts=yes
END
