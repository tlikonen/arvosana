# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = Arvosana

CONFIG += sailfishapp

SOURCES += src/Arvosana.cpp

OTHER_FILES += qml/Arvosana.qml \
    qml/cover/CoverPage.qml \
    rpm/Arvosana.changes.in \
    rpm/Arvosana.spec \
    rpm/Arvosana.yaml \
    Arvosana.desktop \
    qml/pages/Taulukko.qml \
    qml/pages/Tietosivu.qml \
    qml/pages/Yhteinen.js

# to disable building translations every time, comment out the
# following CONFIG line
# CONFIG += sailfishapp_i18n
# TRANSLATIONS += translations/Arvosana-de.ts

