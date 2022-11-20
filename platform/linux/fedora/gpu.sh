#!/usr/bin/env bash
#
sudo dnf install -y ffmpeg libva libva-utils 

sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
