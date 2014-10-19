import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Rectangle {
        color: "transparent"
        border.color: Theme.secondaryColor
        border.width: 2
        radius: 20
        anchors.centerIn: parent
        width: parent.width * 0.8
        height: parent.height * 0.8

        Label {
            anchors.centerIn: parent
            color: Theme.primaryColor
            text: qsTr("Arvosanat")
        }
    }
}


