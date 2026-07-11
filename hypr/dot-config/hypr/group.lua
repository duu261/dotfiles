local Colors = require("macchiato")
local vars = require("variables")

hl.config({
  group = {
    col = {
      border_active = vars.activeWindowBorderColour,
      border_inactive = vars.inactiveWindowBorderColour,
      border_locked_active = vars.activeWindowBorderColour,
      border_locked_inactive = vars.inactiveWindowBorderColour,
    },
    groupbar = {
      font_family = vars.groupbarFontFamily,
      font_size = vars.groupbarFontSize,
      gradients = true,
      gradient_round_only_edges = false,
      gradient_rounding = vars.groupbarGradientRounding,
      height = vars.groupbarHeight,
      indicator_height = 0,
      gaps_in = vars.groupbarGapsIn,
      gaps_out = vars.groupbarGapsOut,
      text_color = Colors.crust,
      col = {
        active = "rgba(" .. Colors.lavenderAlpha .. "d4)",
        inactive = "rgba(" .. Colors.overlay1Alpha .. "d4)",
        locked_active = "rgba(" .. Colors.lavenderAlpha .. "d4)",
        locked_inactive = "rgba(" .. Colors.subtext1Alpha .. "d4)",
      },
    },
  },
})
