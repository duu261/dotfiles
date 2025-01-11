local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Macchiato",
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 14,
	enable_wayland = false,

	enable_tab_bar = false,
	window_decorations = "RESIZE",
	scrollback_lines = 6000,
	term = "xterm-256color",

	-- just use tmux for this
	-- leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 },
	-- keys = {
	-- 	{ key = "c", mods = "LEADER", action = action({ SpawnTab = "CurrentPaneDomain" }) },
	-- 	{ key = "v", mods = "LEADER", action = action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	-- 	{ key = "s", mods = "LEADER", action = action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	--
	-- 	{ key = "x", mods = "LEADER", action = action({ CloseCurrentPane = { confirm = true } }) },
	-- 	{ key = "w", mods = "LEADER", action = action({ CloseCurrentTab = { confirm = true } }) },
	--
	-- 	{ key = "h", mods = "LEADER", action = action({ ActivatePaneDirection = "Left" }) },
	-- 	{ key = "l", mods = "LEADER", action = action({ ActivatePaneDirection = "Right" }) },
	-- 	{ key = "k", mods = "LEADER", action = action({ ActivatePaneDirection = "Up" }) },
	-- 	{ key = "j", mods = "LEADER", action = action({ ActivatePaneDirection = "Down" }) },
	--
	-- 	{ key = "n", mods = "LEADER", action = action({ ActivateTabRelative = -1 }) },
	-- 	{ key = "p", mods = "LEADER", action = action({ ActivateTabRelative = 1 }) },
	--
	-- 	{ key = "/", mods = "LEADER", action = action({ Search = { CaseInSensitiveString = "" } }) },
	-- 	{ key = "m", mods = "LEADER", action = action.TogglePaneZoomState },
	--
	-- 	{ key = "h", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Left", 20 }) },
	-- 	{ key = "l", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Right", 20 }) },
	-- 	{ key = "j", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Down", 7 }) },
	-- 	{ key = "k", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Up", 5 }) },
	--
	-- 	{ key = "1", mods = "LEADER", action = action.ActivateTab(0) },
	-- 	{ key = "2", mods = "LEADER", action = action.ActivateTab(1) },
	-- 	{ key = "3", mods = "LEADER", action = action.ActivateTab(2) },
	-- 	{ key = "4", mods = "LEADER", action = action.ActivateTab(3) },
	-- 	{ key = "5", mods = "LEADER", action = action.ActivateTab(4) },
	--
	-- 	{ key = "Enter", mods = "LEADER", action = action.ActivateCopyMode },
	--
	-- 	{ key = "Space", mods = "LEADER", action = wezterm.action.RotatePanes("Clockwise") },
	-- 	{
	-- 		key = "0",
	-- 		mods = "LEADER",
	-- 		action = wezterm.action.PaneSelect({
	-- 			mode = "SwapWithActive",
	-- 		}),
	-- 	},
	-- },
}
