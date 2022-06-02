local wezterm = require "wezterm";
return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  native_macos_fullscreen_mode = true,
  exit_behavior = "Close",
  initial_cols=1920,
  initial_rows=1080,
  tab_max_width = 16,
  use_fancy_tab_bar=false,
  native_macos_fullscreen_mode = true,
  keys = {
    {key="f", mods="CMD|CTRL", action="ToggleFullScreen"},
    {key="d", mods="CMD|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="d", mods="CMD", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="]", mods="CMD", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="[", mods="CMD", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="UpArrow", mods="CMD", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="DownArrow", mods="CMD", action=wezterm.action{ActivatePaneDirection="Down"}},
  },
  -- taken from https://github.com/wez/wezterm/blob/7deb215303ce1a8e64d48f65ef3e0a1d24fc2fbc/assets/colors/AtomOneLight.toml
  color_scheme = "AtomOneLight",
  color_schemes = {
    ["AtomOneLight"] = {
      foreground = "#2a2c33",
      background = "#f9f9f9",
      cursor_bg = "#bbbbbb",
      cursor_border = "#bbbbbb",
      cursor_fg = "#ffffff",
      selection_bg = "#ededed",
      selection_fg = "#2a2c33",
      ansi = {"#000000","#de3e35","#3f953a","#7f6000","#2f5af3","#950095","#3f953a","#bbbbbb"},
      brights = {"#000000","#de3e35","#3f953a","#7f6000","#2f5af3","#a00095","#3f953a","#ffffff"},
    },
  },
}
