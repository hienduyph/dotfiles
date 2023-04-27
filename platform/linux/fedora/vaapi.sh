#!/usr/bin/env bash
# https://fedoraproject.org/wiki/Firefox_Hardware_acceleration#Configure_VA-API_Video_decoding_on_AMD
sudo dnf install -y libva libva-utils libavcodec-freeworld mesa-va-drivers-freeworld ffmpeg-free 

# https://rpmfusion.org/Howto/Multimedia#Hardware_codecs_with_AMD_.28mesa.29
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
