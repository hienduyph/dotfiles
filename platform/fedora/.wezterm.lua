local wezterm = require "wezterm";
return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size=9.6,
  color_scheme = "Gruvbox Dark",
  exit_behavior = "Close",
  keys = {
    {key="d", mods="ALT|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="d", mods="ALT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="t", mods="ALT", action=wezterm.action{SpawnTab="DefaultDomain"}},
    {key="]", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="[", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="UpArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="DownArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
  },
}
