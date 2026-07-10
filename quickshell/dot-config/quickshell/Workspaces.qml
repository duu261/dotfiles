import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
  spacing: 4

  Repeater {
    model: Hyprland.workspaces
    delegate: Rectangle {
      required property var modelData
      width: 20
      height: 20
      radius: Theme.radius
      color: modelData.active ? Theme.lavender : "transparent"
      border.width: 1
      border.color: Theme.surface0

      Text {
        anchors.centerIn: parent
        text: modelData.id
        color: modelData.active ? Theme.crust : Theme.subtext0
        font.family: Theme.fontMono
        font.pixelSize: 12
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + modelData.id)
      }
    }
  }
}
