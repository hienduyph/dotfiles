#!/bin/bash
set -ex

sudo dnf update -y && sudo dnf upgrade -y && sudo dnf autoremove -y
