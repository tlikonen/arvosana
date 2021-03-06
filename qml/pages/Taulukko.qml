import QtQuick 2.0
import Sailfish.Silica 1.0
import "Yhteinen.js" as Yhteinen

Page {
    id: page

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingLarge
        spacing: 0

        PageHeader {
            title: "Arvosanataulukko"
        }

        Row {
            width: parent.width
            height: Theme.itemSizeLarge
            Label {
                width: parent.width / 3
                color: Theme.highlightColor
                text: "Pisteet"
            }
            Label {
                width: parent.width / 3
                color: Theme.highlightColor
                text: "Arvosana"
            }
            Label {
                width: parent.width / 3
                color: Theme.highlightColor
                text: "%"
            }
        }

        SilicaListView {
            width: parent.width
            height: page.height * 0.68
            model: Yhteinen.taulukko
            delegate: Row {
                width: parent.width
                height: Theme.itemSizeSmall * 0.8
                Label {
                    width: parent.width / 3
                    text: modelData[0]
                    color: modelData[3] ? Theme.primaryColor : Theme.secondaryColor
                }
                Label {
                    width: parent.width / 3
                    text: modelData[1]
                    color: modelData[3] ? Theme.primaryColor : Theme.secondaryColor
                }
                Label {
                    width: parent.width / 3
                    text: modelData[2]
                    color: modelData[3] ? Theme.primaryColor : Theme.secondaryColor
                }
            }
            VerticalScrollDecorator {}
        }
    }
}
