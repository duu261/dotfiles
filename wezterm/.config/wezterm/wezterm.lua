local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Macchiato",

	enable_wayland = false,
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 14,

	enable_tab_bar = false,
	window_decorations = "RESIZE",
	scrollback_lines = 3000,
}
