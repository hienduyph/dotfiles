sudo apt-get install libinput-tools xdotool -y

sudo gpasswd -a $USER input

git clone https://github.com/bulletmark/libinput-gestures.git ~/Applications/libinput-gestures
cd ~/Applications/libinput-gestures
sudo make install
sudo ./libinput-gestures-setup install
