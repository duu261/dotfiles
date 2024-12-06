local wezterm = require 'wezterm'

local config = {}

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 12

config.color_scheme = 'Catppuccin Macchiato'

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

return config
