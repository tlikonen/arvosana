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

                Tietoavain { text: "Suurin arvosana"; }
                Tietoarvo { id: suurin; text: "10"; }

                Tietoavain { text: "Pienin arvosana"; }
                Tietoarvo { id: pienin; text: "4"; }

                Tietoavain { text: "Kynnysarvosana"; }
                Tietoarvo { id: kynnysarvosana; text: "4,75"; }

                Tietoavain { text: "Kynnysprosentti"; }
                Tietoarvo { id: kynnysprosentti; text: "25"; }

                Tietoavain { text: "Maksimipisteet"; }
                Tietoarvo { id: maksimipisteet; text: "30"; }

                Tietoavain { text: "Pisteväli"; }
                Tietoarvo { id: pistevali; text: "1"; }
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


