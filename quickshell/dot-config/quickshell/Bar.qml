import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
  id: bar
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 32
  color: Theme.mantle

  RowLayout {
    id: leftGroup
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 8
    spacing: 8
    Workspaces {}
  }

  RowLayout {
    id: centerGroup
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    spacing: 8
    WindowTitle {}
    Clock {}
  }

  RowLayout {
    id: rightGroup
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 8
    spacing: 8
    Tray {}
  }
}
