#!/bin/bash

echo "Backup gnome term config"

dconf dump /org/gnome/terminal/ > ./gnome-terminal.dconf
