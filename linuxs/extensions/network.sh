#!/bin/bash

set -e

echo "Setting Nameserver"

sudo tee /etc/systemd/resolved.conf << END
[Resolve]
DNS=127.0.0.1 8.8.8.8 1.1.1.1
FallbackDNS=9.9.9.9
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=yes
#DNSStubListener=yes
#ReadEtcHosts=yes
END
