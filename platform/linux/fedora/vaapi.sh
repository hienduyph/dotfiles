#!/usr/bin/env bash
# https://rpmfusion.org/Howto/Multimedia
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y

# https://fedoraproject.org/wiki/Firefox_Hardware_acceleration#Configure_VA-API_Video_decoding_on_AMD

sudo dnf install -y libva libva-utils libavcodec-freeworld mesa-va-drivers-freeworld
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y

# https://rpmfusion.org/Howto/Multimedia#Hardware_codecs_with_AMD_.28mesa.29
