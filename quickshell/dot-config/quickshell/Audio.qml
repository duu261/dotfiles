import QtQuick
import Quickshell.Services.Pipewire

Text {
  color: Theme.text
  font.family: Theme.fontMono
  font.pixelSize: 13
  text: {
    if (!Pipewire.defaultSink) return ""
    const pct = Math.round(Pipewire.defaultSink.volume * 100)
    return Pipewire.defaultSink.muted ? "" : " " + pct + "%"
  }

  MouseArea {
    anchors.fill: parent
    onWheel: (wheel) => {
      if (!Pipewire.defaultSink) return
      const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
      Pipewire.defaultSink.volume = Math.max(0, Math.min(1, Pipewire.defaultSink.volume + delta))
    }
    onClicked: {
      if (Pipewire.defaultSink) Pipewire.defaultSink.muted = !Pipewire.defaultSink.muted
    }
  }
}
