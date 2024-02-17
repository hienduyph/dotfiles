local wezterm = require("wezterm")
local mux = wezterm.mux

local q = require("q.common")
local raw_os_name = io.popen("uname -s", "r"):read("*l"):lower()

local out = {
	font = wezterm.font("JetBrainsMono NF", { weight = "Regular" }),
	font_size = 10,
	tab_max_width = 16,
	use_fancy_tab_bar = false,
	exit_behavior = "Close",
	initial_cols = 160,
	initial_rows = 40,
	window_frame = {
		font_size = 10.0,
	},
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
	color_scheme = "Flexoki",
	color_schemes = q.colors,
	-- color_scheme = "Github (base16)",
	-- color_scheme = "Github (Gogh)",
	bold_brightens_ansi_colors = true,
}

if string.find(raw_os_name, "linux") ~= nil then
	out["keys"] = q.linux_keys
	out["window_decorations"] = "TITLE"
else
	out["keys"] = q.mac_keys
	out["font_size"] = 14
	out["native_macos_fullscreen_mode"] = true
	out["window_decorations"] = "TITLE | RESIZE"
	--out["freetype_load_target"] = "Light"
end

local wayland_env = os.getenv("WAYLAND_DISPLAY")
wayland_env = wayland_env or ""

if string.find(wayland_env:lower(), "wayland") ~= nil then
	out["window_decorations"] = "NONE"
	out["enable_wayland"] = true
end

local high_dpi = os.getenv("WEZTERM_FONT_SIZE")
if high_dpi ~= nil and high_dpi ~= "" then
	out["font_size"] = tonumber(high_dpi)
end

local _, mod = pcall(require, "q.custom")
if mod then
	out.ssh_domains = mod.ssh_domains
end

-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)

return out
