import QtQuick
import Quickshell.Services.UPower

Text {
  visible: UPower.displayDevice && UPower.displayDevice.isPresent
  color: Theme.text
  font.family: Theme.fontMono
  font.pixelSize: 12
  text: {
    if (!UPower.displayDevice) return ""
    const pct = Math.round(UPower.displayDevice.percentage * 100)
    const charging = UPower.displayDevice.state === UPowerDeviceState.Charging
    return (charging ? "\uf0e7 " : "\uf240 ") + pct + "%"
  }
}
