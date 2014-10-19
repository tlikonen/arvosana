import QtQuick 2.0
import Sailfish.Silica 1.0

TextField {
    width: column.width / 2
    inputMethodHints: Qt.ImhFormattedNumbersOnly
    EnterKey.enabled: text.length > 0
    EnterKey.onClicked: {
        focus = false
        virhe.text = ""
    }
}
