import QtQuick
import Quickshell.Networking

Text {
  color: Theme.text
  font.family: Theme.fontMono
  font.pixelSize: 12
  text: Network.connected ? " " + Network.activeConnectionName : " offline"
}
