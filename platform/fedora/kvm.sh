#!/usr/bin/env bash

sudo dnf group install --with-optional virtualization -y
sudo dnf install libvirt-devel libguestfs-tools-c libvirt libxml2-devel libxslt-devel flex bison vagrant vagrant-libvirt -y
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

vagrant plugin install vagrant-libvirt 
