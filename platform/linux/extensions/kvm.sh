
#!/bin/bash
set -e

_kvm () {
  sudo apt-get install -y \
    qemu-system\
    qemu-utils\
    virt-manager\
    qemu-kvm\
    libvirt-daemon-system\
    libvirt-clients\
    bridge-utils

  sudo adduser `id -un` libvirt
  sudo adduser `id -un` kvm
}


_vagrant() {
  version=${1:-2.2.10}
  curl -Lo /tmp/vagrant.deb https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.deb
  sudo apt install /tmp/vagrant.deb
  rm -f /tmp/vagrant.deb
  sudo apt install libvirt-dev  -y

  CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt --with-libvirt-lib=/usr/lib/libvirt" vagrant plugin install vagrant-libvirt
}

_kvm
_vagrant "2.2.10"
