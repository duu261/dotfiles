local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Macchiato",
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 16,
	enable_wayland = false,
	enable_tab_bar = false,
	xcursor_theme = "catppuccin-macchiato-red-cursors",
	window_decorations = "RESIZE",
	scrollback_lines = 10000,
	term = "xterm-256color",
	check_for_updates = false,
	audible_bell = "Disabled",
	default_cursor_style = "SteadyBlock",
	window_padding = {
		left = 4,
		right = 4,
		top = 2,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
}
