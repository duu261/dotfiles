-- Ported from autostart.conf

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl dispatch workspace 1")
  hl.exec_cmd("hyprctl setcursor catppuccin-macchiato-red-cursors 24")
  hl.exec_cmd("udiskie")

  -- Keyring and auth
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

  -- Clipboard history
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  -- Forward bluetooth media commands to MPRIS
  hl.exec_cmd("mpris-proxy")

  -- caelestia resizer/shell dropped — no replacement until Quickshell surfaces ship
end)
