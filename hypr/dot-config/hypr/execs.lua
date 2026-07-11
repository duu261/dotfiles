local vars = require("variables")

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl dispatch workspace 1")
  hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. vars.cursorTheme)
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)
  hl.exec_cmd("udiskie")

  -- Auto delete trash 30 days old
  hl.exec_cmd("trash-empty 30")

  -- Location provider and night light
  hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
  hl.exec_cmd("sleep 1 && gammastep")

  -- Keyring and auth
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")

  -- Clipboard history
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  -- Forward bluetooth media commands to MPRIS
  hl.exec_cmd("mpris-proxy")

  hl.exec_cmd("caelestia resizer -d")
  hl.exec_cmd("caelestia shell -d")
end)
