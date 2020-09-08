#/bin/bash
set -e

version=$1
version="${version:-1.27.0-rc3}"
echo "Install docker-compose version $version"
sudo curl -L "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
