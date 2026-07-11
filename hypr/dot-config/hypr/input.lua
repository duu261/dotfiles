local vars = require("variables")

hl.config({
  input = {
    kb_layout = "us",
    numlock_by_default = false,
    repeat_delay = vars.inputRepeatDelay,
    repeat_rate = vars.inputRepeatRate,
    focus_on_close = 1,
    touchpad = {
      natural_scroll = true,
      disable_while_typing = vars.touchpadDisableTyping,
      scroll_factor = vars.touchpadScrollFactor,
    },
  },
  binds = {
    scroll_event_delay = 0,
  },
  cursor = {
    hotspot_padding = 1,
  },
  gestures = {
    workspace_swipe_distance = vars.workspaceSwipeDistance,
    workspace_swipe_cancel_ratio = vars.workspaceSwipeCancelRatio,
    workspace_swipe_min_speed_to_force = vars.workspaceSwipeMinSpeedToForce,
    workspace_swipe_direction_lock = true,
    workspace_swipe_direction_lock_threshold = vars.workspaceSwipeDirectionLockThreshold,
    workspace_swipe_create_new = true,
  },
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = vars.mouseSensitivity,
})
