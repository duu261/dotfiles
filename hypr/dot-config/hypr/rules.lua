local fn = require("functions")
local vars = require("variables")

-- Ported from windows.conf

hl.window_rule({ name = "fullscreen-opacity", match = { fullscreen = false }, opacity = vars.windowOpacity .. " override" })

hl.window_rule({ name = "opaque-native-transparency", match = { class = "equibop|org\\.quickshell|imv|swappy" }, opaque = true })
hl.window_rule({ name = "center-floating", match = { float = true, xwayland = false }, center = true })

hl.window_rule({ name = "tiled-no-shadow", match = { float = false }, no_shadow = true })

-- Float
hl.window_rule({ name = "float-guifetch", match = { class = "guifetch" }, float = true })
hl.window_rule({ name = "float-yad", match = { class = "yad" }, float = true })
hl.window_rule({ name = "float-zenity", match = { class = "zenity" }, float = true })
hl.window_rule({ name = "float-wev", match = { class = "wev" }, float = true })
hl.window_rule({ name = "float-filerollerA", match = { class = "org\\.gnome\\.FileRoller" }, float = true })
hl.window_rule({ name = "float-filerollerB", match = { class = "file-roller" }, float = true })
hl.window_rule({ name = "float-gradience", match = { class = "com\\.github\\.GradienceTeam\\.Gradience" }, float = true })
hl.window_rule({ name = "float-feh", match = { class = "feh" }, float = true })
hl.window_rule({ name = "float-imv", match = { class = "imv" }, float = true })
hl.window_rule({ name = "float-printer", match = { class = "system-config-printer" }, float = true })
hl.window_rule({ name = "float-quickshell", match = { class = "org\\.quickshell" }, float = true })

-- Float, resize and center
hl.window_rule({ name = "gnome-settings-float", match = { class = "org\\.gnome\\.Settings" }, float = true })
hl.window_rule({ name = "gnome-settings-size", match = { class = "org\\.gnome\\.Settings" }, size = "70% 80%" })
hl.window_rule({ name = "gnome-settings-center", match = { class = "org\\.gnome\\.Settings" }, center = 1 })
hl.window_rule({ name = "pavucontrol-float", match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, float = true })
hl.window_rule({ name = "pavucontrol-size", match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, size = "60% 70%" })
hl.window_rule({ name = "pavucontrol-center", match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, center = 1 })
hl.window_rule({ name = "nwg-look-float", match = { class = "nwg-look" }, float = true })
hl.window_rule({ name = "nwg-look-size", match = { class = "nwg-look" }, size = "50% 60%" })
hl.window_rule({ name = "nwg-look-center", match = { class = "nwg-look" }, center = 1 })

-- Special workspaces
hl.window_rule({ name = "ws-sysmon", match = { class = "btop" }, workspace = "special:sysmon" })
hl.window_rule({ name = "ws-music-class", match = { class = "feishin|Spotify|Supersonic|Cider|com.github.th_ch.youtube_music|Plexamp|com-maxrave-simpmusic-MainKt" }, workspace = "special:music" })
hl.window_rule({ name = "ws-music-title", match = { initial_title = "Spotify( Free)?" }, workspace = "special:music" })
hl.window_rule({ name = "ws-communication", match = { class = "discord|equibop|vesktop|whatsapp" }, workspace = "special:communication" })
hl.window_rule({ name = "ws-todo", match = { class = "Todoist" }, workspace = "special:todo" })

-- Dialogs
hl.window_rule({ name = "dialog-select-file", match = { title = "(Select|Open)( a)? (File|Folder)(s)?" }, float = true })
hl.window_rule({ name = "dialog-file-op", match = { title = "File (Operation|Upload)( Progress)?" }, float = true })
hl.window_rule({ name = "dialog-properties", match = { title = ".* Properties" }, float = true })
hl.window_rule({ name = "dialog-export-png", match = { title = "Export Image as PNG" }, float = true })
hl.window_rule({ name = "dialog-gimp-crash", match = { title = "GIMP Crash Debug" }, float = true })
hl.window_rule({ name = "dialog-save-as", match = { title = "Save As" }, float = true })
hl.window_rule({ name = "dialog-library", match = { title = "Library" }, float = true })

-- Picture in picture
hl.window_rule({ name = "pip-move", match = { title = "Picture(-| )in(-| )[Pp]icture" }, move = "(monitor_w*0.98-window_w) (monitor_h*0.97-window_h)" })
hl.window_rule({ name = "pip-aspect", match = { title = "Picture(-| )in(-| )[Pp]icture" }, keep_aspect_ratio = true })
hl.window_rule({ name = "pip-float", match = { title = "Picture(-| )in(-| )[Pp]icture" }, float = true })
hl.window_rule({ name = "pip-pin", match = { title = "Picture(-| )in(-| )[Pp]icture" }, pin = true })

-- Creative software
hl.window_rule({ name = "creative-opaque", match = { class = "krita|gimp|inkscape|darktable|resolve|kdenlive|shotcut|blender|godot" }, opaque = true })

-- Ueberzugpp
hl.window_rule({ name = "ueberzug-float", match = { class = "^(ueberzugpp_.*)$" }, float = true })
hl.window_rule({ name = "ueberzug-nofocus", match = { class = "^(ueberzugpp_.*)$" }, no_initial_focus = true })

-- Steam
hl.window_rule({ name = "steam-rounding", match = { class = "steam" }, rounding = vars.windowRounding })
hl.window_rule({ name = "steam-friends-float", match = { title = "Friends List", class = "steam" }, float = true })

-- Games
hl.window_rule({ name = "games-opaque", match = { class = "(steam_app_(default|[0-9]+))|gamescope" }, opaque = true })
hl.window_rule({ name = "games-immediate", match = { class = "(steam_app_(default|[0-9]+))|gamescope" }, immediate = true })
hl.window_rule({ name = "games-idle-inhibit", match = { class = "(steam_app_(default|[0-9]+))|gamescope" }, idle_inhibit = "always" })

-- Minecraft launcher consoles
hl.window_rule({ name = "atlauncher-console-float", match = { class = "com-atlauncher-App", title = "ATLauncher Console" }, float = true })
hl.window_rule({ name = "pandora-console-float", match = { class = "PandoraLauncher", title = "Minecraft Game Output" }, float = true })

-- Autodesk Fusion 360
hl.window_rule({ name = "fusion360-noblur", match = { title = "Fusion360|(Marking Menu)", class = "fusion360\\.exe" }, no_blur = true })

-- Xwayland popups
hl.window_rule({ name = "xwayland-popup-nodim", match = { xwayland = 1, title = "win[0-9]+" }, no_dim = true })
hl.window_rule({ name = "xwayland-popup-noshadow", match = { xwayland = 1, title = "win[0-9]+" }, no_shadow = true })
hl.window_rule({ name = "xwayland-popup-rounding", match = { xwayland = 1, title = "win[0-9]+" }, rounding = vars.windowRounding })
hl.window_rule({ name = "xwayland-empty-popup-nodim", match = { xwayland = true, title = "", class = "", initial_title = "", initial_class = "" }, no_dim = true })
hl.window_rule({ name = "xwayland-empty-popup-noshadow", match = { xwayland = true, title = "", class = "", initial_title = "", initial_class = "" }, no_shadow = true })
hl.window_rule({ name = "xwayland-empty-popup-noblur", match = { xwayland = true, title = "", class = "", initial_title = "", initial_class = "" }, no_blur = true })
hl.window_rule({ name = "xwayland-empty-popup-opaque", match = { xwayland = true, title = "", class = "", initial_title = "", initial_class = "" }, opaque = true })
hl.window_rule({ name = "xwayland-empty-popup-rounding", match = { xwayland = true, title = "", class = "", initial_title = "", initial_class = "" }, rounding = vars.windowRounding })

-- Workspace gap overrides
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = vars.singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = vars.singleWindowGapsOut })

-- Layer rules
hl.layer_rule({ name = "hyprpicker-fade", match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ name = "logout-dialog-fade", match = { namespace = "logout_dialog" }, animation = "fade" })
hl.layer_rule({ name = "selection-fade", match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ name = "wayfreeze-fade", match = { namespace = "wayfreeze" }, animation = "fade" })

-- Fuzzel
hl.layer_rule({ name = "launcher-popin", match = { namespace = "launcher" }, animation = "popin 80%" })
hl.layer_rule({ name = "launcher-blur", match = { namespace = "launcher" }, blur = true })

-- Shell
hl.layer_rule({ name = "caelestia-no-anim", match = { namespace = "caelestia-(border-exclusion|area-picker)" }, no_anim = true })
hl.layer_rule({ name = "caelestia-fade", match = { namespace = "caelestia-(drawers|background)" }, animation = "fade" })
