local wezterm = require "wezterm";
return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size=9.6,
  color_scheme = "Gruvbox Dark",
  exit_behavior = "Close",
  window_decorations = "NONE",
  window_frame = {
    font_size=10.0,
  },
  keys = {
    {key="d", mods="ALT|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="d", mods="ALT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="t", mods="ALT", action=wezterm.action{SpawnTab="DefaultDomain"}},
    {key="]", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="[", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="UpArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="DownArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="1", mods="ALT", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="ALT", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="ALT", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="ALT", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="ALT", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="ALT", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="ALT", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="ALT", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="ALT", action=wezterm.action{ActivateTab=8}},
  },
}
