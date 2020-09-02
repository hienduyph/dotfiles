sudo snap install flutter --classic
sudo snap install android-studio --classic
sudo apt install -y\
  qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils \
  virt-manager

sudo adduser `id -un` libvirt
sudo adduser `id -un` kvm
