local wezterm = require 'wezterm'

local config = {}

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 14

config.color_scheme = 'Catppuccin Macchiato'

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- Disable Ctrl + Shift + P
config.keys = {
  {key="P", mods="CTRL|SHIFT", action=wezterm.action.DisableDefaultAssignment},
  -- Disable Ctrl + Shift + N
  {key="N", mods="CTRL|SHIFT", action=wezterm.action.DisableDefaultAssignment},
}

return config

