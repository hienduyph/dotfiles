local M = {};
local wezterm = require("wezterm")

M.hello = function()
  local a = 1
end


-- taken from https://github.com/wez/wezterm/blob/7deb215303ce1a8e64d48f65ef3e0a1d24fc2fbc/assets/colors/AtomOneLight.toml
M.colors = {
  ["AtomOneLight"] = {
    foreground = "#2a2c33",
    background = "#f9f9f9",
    cursor_bg = "#bbbbbb",
    cursor_border = "#bbbbbb",
    cursor_fg = "#ffffff",
    selection_bg = "#ededed",
    selection_fg = "#2a2c33",
    ansi = { "#000000", "#de3e35", "#3f953a", "#7f6000", "#2f5af3", "#950095", "#3f953a", "#bbbbbb" },
    brights = { "#000000", "#de3e35", "#3f953a", "#7f6000", "#2f5af3", "#a00095", "#3f953a", "#ffffff" },
  },
}

M.linux_keys = {
  { key = "d", mods = "ALT|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "d", mods = "ALT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "t", mods = "ALT", action = wezterm.action { SpawnTab = "DefaultDomain" } },
  { key = "]", mods = "ALT", action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "[", mods = "ALT", action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "UpArrow", mods = "ALT", action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "DownArrow", mods = "ALT", action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "1", mods = "ALT", action = wezterm.action { ActivateTab = 0 } },
  { key = "2", mods = "ALT", action = wezterm.action { ActivateTab = 1 } },
  { key = "3", mods = "ALT", action = wezterm.action { ActivateTab = 2 } },
  { key = "4", mods = "ALT", action = wezterm.action { ActivateTab = 3 } },
  { key = "5", mods = "ALT", action = wezterm.action { ActivateTab = 4 } },
  { key = "6", mods = "ALT", action = wezterm.action { ActivateTab = 5 } },
  { key = "7", mods = "ALT", action = wezterm.action { ActivateTab = 6 } },
  { key = "8", mods = "ALT", action = wezterm.action { ActivateTab = 7 } },
  { key = "9", mods = "ALT", action = wezterm.action { ActivateTab = 8 } },
}

M.mac_keys = {
  { key = "f", mods = "CMD|CTRL", action = "ToggleFullScreen" },
  { key = "d", mods = "CMD|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "d", mods = "CMD", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "]", mods = "CMD", action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "[", mods = "CMD", action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "UpArrow", mods = "CMD", action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "DownArrow", mods = "CMD", action = wezterm.action { ActivatePaneDirection = "Down" } },
}

return M;
