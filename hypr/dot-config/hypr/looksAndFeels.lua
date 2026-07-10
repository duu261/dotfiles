-- Ported from looksAndFeels.conf

local Colors = require("macchiato")

hl.config({
  general = {
    layout = "dwindle",
    allow_tearing = false,
    gaps_workspaces = 20,
    gaps_in = 10,
    gaps_out = 40,
    border_size = 3,
    col = {
      active_border   = { colors = { "rgba(" .. Colors.red .. "ee)", "rgba(" .. Colors.maroon .. "ee)" }, angle = 45 },
      inactive_border = { colors = { "rgba(" .. Colors.surface0 .. "ee)", "rgba(" .. Colors.surface2 .. "ee)" }, angle = 45 },
    },
    resize_on_border = true,
  },

  decoration = {
    rounding = 10,
    blur = {
      enabled = true,
      xray = false,
      special = false,
      ignore_opacity = true,
      new_optimizations = true,
      popups = true,
      input_methods = true,
      size = 8,
      passes = 2,
    },
    shadow = {
      enabled = true,
      range = 20,
      render_power = 3,
      color = "rgba(" .. Colors.crust .. "ee)",
    },
  },

  dwindle = {
    preserve_split = true,
    smart_split = false,
    smart_resizing = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    vrr = 1,
    animate_manual_resizes = false,
    animate_mouse_windowdragging = false,
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
    allow_session_lock_restore = true,
    on_focus_under_fullscreen = 2,
    middle_click_paste = false,
    focus_on_activate = true,
    session_lock_xray = true,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
    background_color = Colors.crust,
  },

  -- debug/group categories unconfirmed by shipped example — reload is the gate
  debug = {
    error_position = 1,
  },

  group = {
    col = {
      border_active          = { colors = { "rgba(" .. Colors.red .. "ee)", "rgba(" .. Colors.maroon .. "ee)" }, angle = 45 },
      border_inactive        = { colors = { "rgba(" .. Colors.surface0 .. "ee)", "rgba(" .. Colors.surface2 .. "ee)" }, angle = 45 },
      border_locked_active   = { colors = { "rgba(" .. Colors.red .. "ee)", "rgba(" .. Colors.maroon .. "ee)" }, angle = 45 },
      border_locked_inactive = { colors = { "rgba(" .. Colors.surface0 .. "ee)", "rgba(" .. Colors.surface2 .. "ee)" }, angle = 45 },
    },
    groupbar = {
      font_family = "FiraCode Code Nerd Font Propo",
      font_size = 15,
      gradients = true,
      gradient_round_only_edges = false,
      gradient_rounding = 5,
      height = 25,
      indicator_height = 0,
      gaps_in = 3,
      gaps_out = 3,
      text_color = "rgba(" .. Colors.text .. "ff)",
      col = {
        active          = "rgba(" .. Colors.red .. "ee)",
        inactive        = "rgba(" .. Colors.surface0 .. "ee)",
        locked_active   = "rgba(" .. Colors.maroon .. "ee)",
        locked_inactive = "rgba(" .. Colors.surface2 .. "ee)",
      },
    },
  },
})

-- Animation curves (hl.curve, NOT hl.bezier)
hl.curve("specialWorkSwitch", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel",  { type = "bezier", points = { { 0.3, 0 },   { 0.8, 0.15 } } })
hl.curve("emphasizedDecel",  { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("standard",         { type = "bezier", points = { { 0.2, 0 },   { 0, 1 } } })

-- Animation configs. Leaf names ported 1:1 where the confirmed leaf set has a match;
-- old leaves with no direct new-leaf equivalent (windowsMove, fadeLayers, specialWorkspace,
-- borderangle) are mapped to the closest confirmed leaf — verify against the wiki and
-- adjust if `hyprctl reload` reports "no such animation leaf".
hl.animation({ leaf = "layersIn",  enabled = true, speed = 5, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 5, bezier = "standard" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 5, bezier = "standard" })

hl.animation({ leaf = "windowsIn",  enabled = true, speed = 5, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "emphasizedAccel" })
hl.animation({ leaf = "windows",    enabled = true, speed = 6, bezier = "standard" }) -- was windowsMove
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "standard" })

hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 4, bezier = "specialWorkSwitch", style = "slidefadevert 15%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4, bezier = "specialWorkSwitch", style = "slidefadevert 15%" })

hl.animation({ leaf = "fadeIn",  enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "fade",    enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "border",  enabled = true, speed = 6, bezier = "standard" })
