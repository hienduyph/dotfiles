sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf update -y

sudo dnf install akmod-nvidia nvidia-persistenced xorg-x11-drv-nvidia-cuda -y

# should outputs the version of the driver such as 440.64 and not modinfo: ERROR: Module nvidia not found.
modinfo -F version nvidia
