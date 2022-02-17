#!/bin/bash

sudo dnf install akmod-nvidia nvidia-persistenced xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-power -y
sudo systemctl enable nvidia-{suspend,resume,hibernate}
