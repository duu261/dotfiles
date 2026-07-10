import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Text {
  text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""
  color: Theme.text
  font.family: Theme.fontUi
  font.pixelSize: 12
  elide: Text.ElideRight
  Layout.maximumWidth: 400
}
