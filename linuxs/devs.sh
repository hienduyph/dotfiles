sudo snap install protobuf --classic
sudo snap install intellij-idea-community --classic

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo add-apt-repository ppa:longsleep/golang-backports

sudo apt install -y \
  nodejs\
  golang-go\
  gcc g++ make

# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
