#!/bin/bash

sudo dnf install -y lightdm
sudo systemctl disable gdm
sudo systemctl enable lightdm

