local Colors = require("macchiato")

return {
  -- Apps
  terminal = "wezterm",
  browser = "zen-browser",
  editor = "codium",
  fileExplorer = "yazi",
  audioSettings = "pavucontrol",

  -- Touchpad and gestures
  touchpadDisableTyping = true,
  touchpadScrollFactor = 0.3,
  inputRepeatDelay = 250,
  inputRepeatRate = 35,
  gestureFingers = 3,
  workspaceSwipeFingers = 4,
  gestureFingersMore = 4,
  workspaceSwipeDistance = 700,
  workspaceSwipeCancelRatio = 0.15,
  workspaceSwipeMinSpeedToForce = 5,
  workspaceSwipeDirectionLockThreshold = 10,
  mouseSensitivity = -0.5,
  sleepGestureCmd = "systemctl suspend-then-hibernate",

  -- Blur
  blurEnabled = true,
  blurSpecialWs = false,
  blurPopups = true,
  blurInputMethods = true,
  blurSize = 8,
  blurPasses = 2,
  blurXray = false,

  -- Shadow
  shadowEnabled = true,
  shadowRange = 15,
  shadowRenderPower = 4,
  shadowColour = "rgba(" .. Colors.lavenderAlpha .. "10)",

  -- Gaps and window styling
  workspaceGaps = 20,
  windowGapsIn = 5,
  windowGapsOut = 10,
  singleWindowGapsOut = 20,
  windowOpacity = 0.95,
  windowRounding = 15,
  windowBorderSize = 3,
  activeWindowBorderColour = { colors = { "rgba(" .. Colors.redAlpha .. "ee)", "rgba(" .. Colors.maroonAlpha .. "ee)" }, angle = 45 },
  inactiveWindowBorderColour = "rgba(" .. Colors.overlay1Alpha .. "11)",

  -- Groupbar
  groupbarFontFamily = "FiraCode Code Nerd Font Propo",
  groupbarFontSize = 15,
  groupbarGradientRounding = 5,
  groupbarHeight = 25,
  groupbarGapsIn = 3,
  groupbarGapsOut = 3,

  -- Misc
  volumeStep = 10,
  volumeMax = 100,
  resizeStep = 10,
  keyboardBacklightStep = 10,
  cursorTheme = "catppuccin-macchiato-red-cursors",
  cursorSize = 24,
}
