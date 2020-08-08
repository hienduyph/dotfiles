curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

sudo apt update
sudo apt install telegram-desktop docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER

sudo systemctl start docker
sudo systemctl enable docker

wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
