import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout {
  spacing: 6

  Repeater {
    model: SystemTray.items
    delegate: Image {
      required property var modelData
      source: modelData.icon
      width: 16
      height: 16

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
          if (mouse.button === Qt.LeftButton) modelData.activate()
          else modelData.display(mouse.x, mouse.y)
        }
      }
    }
  }
}
