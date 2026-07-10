-- Ported from looksAndFeels.conf

local Colors = require("macchiato")

-- Global reduce-motion escape hatch, cheap to wire now even unused
local REDUCE_MOTION = false

local function anim(opts)
  if REDUCE_MOTION then
    opts.enabled = false
  end
  hl.animation(opts)
end

hl.config({
  general = {
    layout = "dwindle",
    allow_tearing = false,
    gaps_workspaces = 20,
    gaps_in = 12,
    gaps_out = 24,
    border_size = 1,
    col = {
      active_border   = { colors = { "rgba(" .. Colors.mauve .. "ee)", "rgba(" .. Colors.lavender .. "ee)" }, angle = 45 },
      inactive_border = { colors = { "rgba(" .. Colors.surface0 .. "ee)", "rgba(" .. Colors.surface2 .. "ee)" }, angle = 45 },
    },
    resize_on_border = true,
  },

  decoration = {
    rounding = 4,
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
      border_active          = { colors = { "rgba(" .. Colors.mauve .. "ee)", "rgba(" .. Colors.lavender .. "ee)" }, angle = 45 },
      border_inactive        = { colors = { "rgba(" .. Colors.surface0 .. "ee)", "rgba(" .. Colors.surface2 .. "ee)" }, angle = 45 },
      border_locked_active   = { colors = { "rgba(" .. Colors.mauve .. "ee)", "rgba(" .. Colors.pink .. "ee)" }, angle = 45 },
      border_locked_inactive = { colors = { "rgba(" .. Colors.surface0 .. "ee)", "rgba(" .. Colors.surface2 .. "ee)" }, angle = 45 },
    },
    groupbar = {
      font_family = "FiraCode Nerd Font Propo",
      font_size = 15,
      gradients = true,
      gradient_round_only_edges = false,
      gradient_rounding = 4,
      height = 25,
      indicator_height = 0,
      gaps_in = 4,
      gaps_out = 4,
      text_color = "rgba(" .. Colors.text .. "ff)",
      col = {
        active          = "rgba(" .. Colors.mauve .. "ee)",
        inactive        = "rgba(" .. Colors.surface0 .. "ee)",
        locked_active   = "rgba(" .. Colors.pink .. "ee)",
        locked_inactive = "rgba(" .. Colors.surface2 .. "ee)",
      },
    },
  },
})

-- Animation curves (hl.curve, NOT hl.bezier)
-- Larger movements (workspace/panel) get spring easing with overshoot allowed
hl.curve("spring",           { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })
hl.curve("emphasizedAccel",  { type = "bezier", points = { { 0.3, 0 },   { 0.8, 0.15 } } })
hl.curve("emphasizedDecel",  { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("standard",         { type = "bezier", points = { { 0.2, 0 },   { 0, 1 } } })

-- Animation configs. Leaf names ported 1:1 where the confirmed leaf set has a match;
-- old leaves with no direct new-leaf equivalent (windowsMove, fadeLayers, specialWorkspace,
-- borderangle) are mapped to the closest confirmed leaf — verify against the wiki and
-- adjust if `hyprctl reload` reports "no such animation leaf".
--
-- Speed unit ~= 100ms. Larger movements (workspace/panel swaps) sit in 300-450ms
-- (speed 3-4.5) with spring/overshoot easing; micro-interactions (fade, border) sit
-- in 120-200ms (speed 1.2-2) with plain ease, never spring.
anim({ leaf = "layersIn",  enabled = true, speed = 4.5, bezier = "emphasizedDecel", style = "slide" })
anim({ leaf = "layersOut", enabled = true, speed = 3.5, bezier = "emphasizedAccel", style = "slide" })
anim({ leaf = "fadeLayersIn",  enabled = true, speed = 2, bezier = "standard" })
anim({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "standard" })

anim({ leaf = "windowsIn",  enabled = true, speed = 4.5, bezier = "emphasizedDecel" })
anim({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "emphasizedAccel" })
anim({ leaf = "windows",    enabled = true, speed = 4,   bezier = "standard" }) -- was windowsMove
anim({ leaf = "workspaces", enabled = true, speed = 4,   bezier = "standard" })

anim({ leaf = "workspacesIn",  enabled = true, speed = 4,   bezier = "spring", style = "slidefadevert 15%" })
anim({ leaf = "workspacesOut", enabled = true, speed = 3.5, bezier = "spring", style = "slidefadevert 15%" })

anim({ leaf = "fadeIn",  enabled = true, speed = 2,   bezier = "standard" })
anim({ leaf = "fadeOut", enabled = true, speed = 2,   bezier = "standard" })
anim({ leaf = "fade",    enabled = true, speed = 1.5, bezier = "standard" })
anim({ leaf = "border",  enabled = true, speed = 1.5, bezier = "standard" })
