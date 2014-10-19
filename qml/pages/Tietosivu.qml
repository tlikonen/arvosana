import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0 as Sql
import "Yhteinen.js" as Yhteinen

Page {
    id: page

    Component.onCompleted: {
        try {
            Yhteinen.kanta = Sql.LocalStorage.openDatabaseSync("Arvosana", "1",
                                                               "Kouluarvosanataulukko", 100);
            Yhteinen.kanta.transaction(function(s) {
                s.executeSql("CREATE TABLE IF NOT EXISTS asetukset (avain TEXT, arvo TEXT)");

                var asetukset = s.executeSql("SELECT avain,arvo FROM asetukset");
                var avain, arvo

                for (var i = 0; i < asetukset.rows.length; i++) {
                    avain = asetukset.rows.item(i).avain;
                    arvo = asetukset.rows.item(i).arvo;
                    if (avain == "suurin" && arvo)
                        suurin.text = arvo;
                    else if (avain == "pienin" && arvo)
                        pienin.text = arvo;
                    else if (avain == "kynnysarvosana" && arvo)
                        kynnysarvosana.text = arvo;
                    else if (avain == "kynnysprosentti" && arvo)
                        kynnysprosentti.text = arvo;
                    else if (avain == "maksimipisteet" && arvo)
                        maksimipisteet.text = arvo;
                    else if (avain == "pisteväli" && arvo)
                        pistevali.text = arvo;
                    else
                        console.log("Tuntematon rivi: " + avain + "=" + arvo);
                }
            })
        } catch (e) {
            console.log("Virhe: " + e);
        }
    }

    Component.onDestruction: {
        try {
            Yhteinen.kanta.transaction(function(s) {
                var avainarvot = [["suurin", suurin.text],
                                  ["pienin", pienin.text],
                                  ["kynnysarvosana", kynnysarvosana.text],
                                  ["kynnysprosentti", kynnysprosentti.text],
                                  ["maksimipisteet", maksimipisteet.text],
                                  ["pisteväli", pistevali.text]];
                var avain, arvo

                for (var i = 0; i < avainarvot.length; i++) {
                    avain = avainarvot[i][0];
                    arvo = avainarvot[i][1];
                    if (s.executeSql("SELECT arvo FROM asetukset WHERE avain = ?", [avain]).rows.length)
                        s.executeSql("UPDATE asetukset SET arvo = ? WHERE avain = ?", [arvo, avain]);
                    else
                        s.executeSql("INSERT INTO asetukset VALUES (?, ?)", [avain, arvo]);
                }
            })
        } catch (e) {
            console.log("Virhe: " + e);
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        anchors.margins: Theme.paddingLarge
        contentHeight: page.height * 1.15

        VerticalScrollDecorator {}

        Column {
            id: column

            width: parent.width
            anchors.fill: parent
            spacing: Theme.paddingSmall

            PageHeader {
                title: "Taulukon lähtötiedot"
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
                    if (Yhteinen.laske_taulukko(suurin.text,
                                                pienin.text,
                                                kynnysarvosana.text,
                                                kynnysprosentti.text,
                                                maksimipisteet.text,
                                                pistevali.text)) {
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


