import QtQuick 2.0
import Sailfish.Silica 1.0
import "Yhteinen.js" as Yhteinen

Page {
    id: page
    property int leveys_tieto: column.width /2
    property int leveys_kentta: column.width /2

    SilicaFlickable {
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium
        contentHeight: page.height * 1.15

        VerticalScrollDecorator {}

        Column {
            id: column

            width: page.width
            anchors.fill: parent
            spacing: Theme.paddingSmall

            PageHeader {
                title: qsTr("Taulukon lähtötiedot")
            }

            Grid {
                rows: 6
                columns: 2
                rowSpacing: 0
                spacing: 0

                Label {
                    text: "Suurin arvosana"
                    width: page.leveys_tieto
                }

                TextField {
                    id: suurin
                    text: "10"
                    width: page.leveys_kentta
                    //validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    EnterKey.enabled: text.length > 0
                    EnterKey.onClicked: { focus = false; virhe.text = ""; }
                }

                Label {
                    text: "Pienin arvosana"
                    width: page.leveys_tieto
                }

                TextField {
                    id: pienin
                    text: "4"
                    width: page.leveys_kentta
                    //validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    EnterKey.enabled: text.length > 0
                    EnterKey.onClicked: { focus = false; virhe.text = ""; }
                }

                Label {
                    text: "Kynnysarvosana"
                    width: page.leveys_tieto
                }

                TextField {
                    id: kynnysarvosana
                    text: "4,75"
                    width: page.leveys_kentta
                    //validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    EnterKey.enabled: text.length > 0
                    EnterKey.onClicked: { focus = false; virhe.text = ""; }
                }

                Label {
                    text: "Kynnysprosentti"
                    width: page.leveys_tieto
                }

                TextField {
                    id: kynnysprosentti
                    text: "25"
                    width: page.leveys_kentta
                    //validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    EnterKey.enabled: text.length > 0
                    EnterKey.onClicked: { focus = false; virhe.text = ""; }
                }

                Label {
                    text: "Maksimipisteet"
                    width: page.leveys_tieto
                }

                TextField {
                    id: maksimipisteet
                    text: "30"
                    width: page.leveys_kentta
                    //validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    EnterKey.enabled: text.length > 0
                    EnterKey.onClicked: { focus = false; virhe.text = ""; }
                }

                Label {
                    text: "Pisteväli"
                    width: page.leveys_tieto
                }

                TextField {
                    id: pistevali
                    text: "1"
                    width: page.leveys_kentta
                    //validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    EnterKey.enabled: text.length > 0
                    EnterKey.onClicked: { focus = false; virhe.text = ""; }
                }
            }

            Button {
                text: "Näytä taulukko"
                onClicked: {
                    if(Yhteinen.laske_taulukko(suurin.text, pienin.text,
                                   kynnysarvosana.text, kynnysprosentti.text,
                                   maksimipisteet.text, pistevali.text)) {
                        virhe.text = "";
                        pageStack.push(Qt.resolvedUrl("Taulukko.qml"));
                    } else {
                        virhe.text = "Kaikki lähtöarvot eivät ole lukuja.";
                    }
                }
                width: column.width * (2 / 3)
                anchors.horizontalCenter: column.horizontalCenter
            }

            Label {
                id: virhe
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.Wrap
                maximumLineCount: 2
                text: ""
            }
        }
    }
}


