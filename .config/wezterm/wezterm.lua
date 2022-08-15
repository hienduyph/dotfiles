local wezterm = require "wezterm";
local q = require("q.common")

local wayland_env = os.getenv("WAYLAND_DISPLAY")
wayland_env = wayland_env or ""

local is_wayland = false
if string.find(wayland_env:lower(), "wayland") then
  is_wayland = true
end

local raw_os_name = io.popen('uname -s', 'r'):read('*l'):lower()

local out = {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size=9,
  tab_max_width = 16,
  use_fancy_tab_bar=false,
  exit_behavior = "Close",
  initial_cols = 160,
  window_decorations = "TITLE",
  enable_wayland = is_wayland,
  initial_rows = 48,
  window_frame = {
    font_size=10.0,
  },
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  color_scheme = "AtomOneLight",
  color_schemes = q.colors,
}

if string.find(raw_os_name, "linux") > 1 then
  out["keys"] = q.linux_keys
else
  out["keys"] = q.mac_keys
end

if is_wayland then
  out["window_decorations"] = "NONE"
end

local high_dpi = os.getenv("HIGH_DPI")
high_dpi = high_dpi or "0"
if string.find(high_dpi, "1")  then
  out["font_size"] = 9.6
end


return out
