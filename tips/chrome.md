# Chrome Tips

## Wayland/Nvidia GPU

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
