# Chrome Tips

## Wayland/Nvidia GPU

**Common Electron Params**
```
--enable-features=UseOzonePlatform --ozone-platform=wayland
```

Notes: Prefer clone the desktop file and modified it.
```
/usr/share/applications/
~/.local/share/flatpak/exports/share/applications
~/.local/share/applications
```

```bash
#!/usr/bin/env bash

flags=(
  --enable-features=UseOzonePlatform
  --ozone-platform=wayland
  --gtk-version=4
  --use-gl=egl
  --enable-zero-copy
  --enable-accelerated-video-decode
  --enable-features=VaapiVideoDecoder
  --enable-features=VaapiVideoEncoder 
  --enable-accelerated-2d-canvas 
  --disable-features=UseChromeOSDirectVideoDecoder
  --disable-gpu-driver-workarounds
  --disable-gpu-driver-bug-workarounds
  --ignore-gpu-blocklist
  --enable-gpu-rasterization
)

/usr/bin/google-chrome-stable "${flags[@]}"
```

```
# ~/.var/app/com.google.Chrome/config/chrome-flags.conf
--enable-features=UseOzonePlatform
--ozone-platform=wayland
--use-gl=egl
--enable-zero-copy
--enable-accelerated-video-decode
--enable-features=VaapiVideoDecoder
--enable-features=VaapiVideoEncoder 
--enable-accelerated-2d-canvas 
--disable-features=UseChromeOSDirectVideoDecoder
--disable-gpu-driver-workarounds
--disable-gpu-driver-bug-workarounds
--ignore-gpu-blocklist
--enable-gpu-rasterization
--gtk-version=4
--enable-features=WaylandWindowDecorations
```
