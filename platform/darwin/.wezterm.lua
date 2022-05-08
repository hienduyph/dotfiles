local wezterm = require "wezterm";
return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  native_macos_fullscreen_mode = true,
  color_scheme = "Gruvbox Dark",
  exit_behavior = "Close",
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
}
