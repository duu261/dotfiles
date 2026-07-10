import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
  spacing: 4

  readonly property int workspaceCount: 5

  Repeater {
    model: workspaceCount
    delegate: Rectangle {
      required property int modelData
      readonly property int wsId: modelData + 1
      readonly property bool active: Hyprland.workspaces.values.some(
        ws => ws.id === wsId && ws.active
      )

      width: 22
      height: 22
      radius: Theme.radius
      color: active ? Theme.lavender : "transparent"
      border.width: 1
      border.color: Theme.surface0

      Text {
        anchors.centerIn: parent
        text: wsId
        color: active ? Theme.crust : Theme.subtext0
        font.family: Theme.fontMono
        font.pixelSize: 14
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + wsId)
      }
    }
  }
}
