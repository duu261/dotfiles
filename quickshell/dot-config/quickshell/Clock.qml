import QtQuick

Text {
  color: Theme.text
  font.family: Theme.fontMono
  font.pixelSize: 13

  property date now: new Date()

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: parent.now = new Date()
  }

  text: Qt.formatDateTime(now, "ddd MMM d  hh:mm:ss")
}
