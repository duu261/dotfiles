local mainMod = "SUPER"
local terminal = "wezterm"
local browser = "zen-browser"
local fileManager = "yazi"
local menu = "rofi -show drun"
local fn = require("functions")
local vars = require("variables")

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"))

hl.bind("CONTROL + SHIFT + MOD1 + V", hl.dsp.exec_cmd('sleep 0.5s && ydotool type -d 1 "$(cliphist list | head -1 | cliphist decode)"'))

-- Shell keybinds
hl.bind(mainMod .. " + Super_L", hl.dsp.global("caelestia:launcher"), { release = true })

hl.define_submap("launcher_interrupt", function()
  hl.bind("catchall", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end)
  hl.bind("mouse:272", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end, { mouse = true })
  hl.bind("mouse:273", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end, { mouse = true })
  hl.bind("mouse:274", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end, { mouse = true })
  hl.bind("mouse:275", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end, { mouse = true })
  hl.bind("mouse:276", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end, { mouse = true })
  hl.bind("mouse:277", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end, { mouse = true })
  hl.bind("mouse_up", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end)
  hl.bind("mouse_down", function()
    hl.dispatch(hl.dsp.global("caelestia:launcherInterrupt"))
    hl.dispatch(hl.dsp.submap("reset"))
  end)
end)

hl.bind(mainMod .. " + Q", hl.dsp.global("caelestia:session"))
hl.bind(mainMod .. " + N", hl.dsp.global("caelestia:sidebar"))
hl.bind("CONTROL + MOD1 + C", hl.dsp.global("caelestia:clearNotifs"), { locked = true })
hl.bind(mainMod .. " + Z", hl.dsp.global("caelestia:showall"))
hl.bind(mainMod .. " + X", hl.dsp.global("caelestia:lock"))

hl.bind(mainMod .. " + MOD1 + X", function()
  hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
  hl.dispatch(hl.dsp.global("caelestia:lock"))
end, { locked = true })

hl.bind("SUPER + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
hl.bind("SUPER + MOD1 + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d"))
hl.bind("SUPER + Period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

hl.bind("CONTROL + SUPER + SHIFT + R", hl.dsp.exec_cmd("qs -c caelestia kill"))
hl.bind("CONTROL + SUPER + MOD1 + R", hl.dsp.exec_cmd("qs -c caelestia kill; sleep .1; caelestia shell -d"))

-- Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("hyprctl dispatch togglegroup"))
hl.bind("ALT + TAB", hl.dsp.group.next(), { repeating = true })
hl.bind("SHIFT + ALT + TAB", hl.dsp.group.prev(), { repeating = true })
hl.bind(mainMod .. " + U", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mainMod .. " + SHIFT + Comma", hl.dsp.group.lock_active())
hl.bind(mainMod .. " + A", hl.dsp.layout("swapsplit"))

-- Utilities
hl.bind("Print", hl.dsp.exec_cmd("caelestia screenshot"), { locked = true })
hl.bind("SUPER + MOD1 + S", hl.dsp.global("caelestia:screenshotFreeze"))
hl.bind("CONTROL + MOD1 + SHIFT + S", hl.dsp.global("caelestia:screenshot"))
hl.bind("SUPER + MOD1 + R", hl.dsp.exec_cmd("caelestia record -s"))
hl.bind("CONTROL + MOD1 + R", hl.dsp.exec_cmd("caelestia record"))
hl.bind("SUPER + SHIFT + MOD1 + R", hl.dsp.exec_cmd("caelestia record -r"))
hl.bind("CONTROL + MOD1 + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Resize windows
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize(fn.resize_active_window(vars.resizeStep, 0)), { repeating = true })
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize(fn.resize_active_window(-vars.resizeStep, 0)), { repeating = true })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize(fn.resize_active_window(0, vars.resizeStep)), { repeating = true })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize(fn.resize_active_window(0, -vars.resizeStep)), { repeating = true })

-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("hyprctl dispatch movewindow l"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprctl dispatch movewindow r"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("hyprctl dispatch movewindow u"))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("hyprctl dispatch movewindow d"))

for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, fn.wsaction("focus", "", i))
  hl.bind(mainMod .. " + SHIFT + " .. i, fn.wsaction("move", "", i))
end
hl.bind(mainMod .. " + 0", fn.wsaction("focus", "", 10))
hl.bind(mainMod .. " + SHIFT + 0", fn.wsaction("move", "", 10))

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("caelestia toggle specialws"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace special:magic"))
hl.bind("CONTROL + SUPER + SHIFT + up", hl.dsp.window.move({ workspace = "special:special" }))
hl.bind("CONTROL + SUPER + SHIFT + down", hl.dsp.window.move({ workspace = "e+0" }))
hl.bind("SUPER + MOD1 + S", hl.dsp.window.move({ workspace = "special:special" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd("hyprctl dispatch workspace e+1"))
hl.bind(mainMod .. " + mouse_up", hl.dsp.exec_cmd("hyprctl dispatch workspace e-1"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true, repeating = true })
hl.bind("CONTROL + SUPER + Space", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("CONTROL + SUPER + Equal", hl.dsp.global("caelestia:mediaNext"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { locked = true })
hl.bind("CONTROL + SUPER + Minus", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.global("caelestia:mediaStop"), { locked = true })

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +" .. vars.keyboardBacklightStep))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s " .. vars.keyboardBacklightStep .. "-"))

hl.bind("SUPER + MOD1 + F12", hl.dsp.exec_cmd("notify-send -u low -i dialog-information-symbolic 'Test notification' \"Here's a really long message to test truncation and wrapping\nYou can middle click or flick this notification to dismiss it!\" -a 'Shell' -A \"Test1=I got it!\" -A \"Test2=Another action\""), { locked = true })
