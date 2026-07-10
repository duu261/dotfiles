-- Ported from input.conf

hl.config({
  input = {
    kb_layout = "us",
    numlock_by_default = false,
    repeat_delay = 250,
    repeat_rate = 35,
    focus_on_close = 1,
    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      scroll_factor = 0.3,
    },
  },

  -- binds/cursor/gestures categories unconfirmed by shipped example — reload is the gate
  binds = {
    scroll_event_delay = 0,
  },

  cursor = {
    hotspot_padding = 1,
  },

  gestures = {
    workspace_swipe_distance = 700,
    workspace_swipe_cancel_ratio = 0.15,
    workspace_swipe_min_speed_to_force = 5,
    workspace_swipe_direction_lock = true,
    workspace_swipe_direction_lock_threshold = 10,
    workspace_swipe_create_new = true,
  },
})

-- Gesture bindings (caelestia specialws toggle dropped — no Quickshell surface backs it in v1)
-- 4-finger swipe-down suspend gesture dropped: only "workspace"/"special" action strings are
-- confirmed by the shipped reference; dispatcher-based gesture actions are unconfirmed.
-- Suspend is still bound via keybindings.lua (SUPER+SHIFT+L).
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up", action = "special" })

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})
