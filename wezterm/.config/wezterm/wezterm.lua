-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.scrollback_lines = 3000 -- Or your desired number of lines
-- config.window_background_opacity = 0.9
-- and finally, return the configuration to wezterm
return config
