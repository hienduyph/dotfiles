#!/bin/bash

sudo dnf install i3 xset redshift dex-autostart rofi feh xev polybar -y

DST=/usr/bin/start-i3

sudo tee $DST << EOF
#!/bin/bash

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

/usr/bin/i3
EOF

sudo chmod +x $DST

sudo tee /usr/share/xsessions/i3.desktop  << EOF
[Desktop Entry]
Name=The Q i3
Comment=An Q's Tiling Windows Manager
Exec=$DST
Type=Application
EOF

