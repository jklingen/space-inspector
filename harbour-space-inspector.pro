#    Space Inspector - a filesystem structure visualization for SailfishOS
#    Copyright (C) 2014 - 2017 Jens Klingen
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

TARGET = harbour-space-inspector

CONFIG += sailfishapp
CONFIG += sailfishapp_i18n


i18n.path = /usr/share/harbour-space-inspector/i18n
i18n.files = i18n/space-inspector_de.qm \
    i18n/space-inspector_es.qm \
    i18n/space-inspector_sv.qm

INSTALLS += i18n

#system(lrelease $$PWD/i18n/*.ts)

SOURCES += src/harbour-space-inspector.cpp \
    src/shell.cpp \
    src/io/engine.cpp \
    src/io/fileworker.cpp \
    src/io/statfileinfo.cpp \
    src/io/globals.cpp

OTHER_FILES += qml/harbour-space-inspector.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-space-inspector.spec \
    rpm/harbour-space-inspector.yaml \
    harbour-space-inspector.desktop \
    qml/pages/TreeMapPage.qml \
    qml/components/TreeMapNode.qml \
    qml/components/GlobalPushUpMenu.qml \
    qml/pages/ListPage.qml \
    cover.png \
    qml/js/IoTranslator.js \
    qml/js/IoTranslator.js \
    qml/js/Memory.js \
    qml/js/Util.js \
    qml/js/treemap-squarify.js \
    qml/components/ShellConnector.qml \
    qml/pages/CoverPage.qml \
    qml/components/ActivityIndicator.qml \
    qml/pages/InfoPage.qml \
    qml/components/NotificationPanel.qml \
    qml/pages/DeleteDialog.qml \
    qml/components/NodeContextMenu.qml \
    qml/components/TreeMapNodeCollapsed.qml\
    qml/components/Spacer.qml \
    qml/pages/PlacesPage.qml \
    qml/components/PlaceButton.qml

HEADERS += \
    src/shell.h \
    src/io/engine.h \
    src/io/fileworker.h \
    src/io/statfileinfo.h \
    src/io/globals.h

RESOURCES += \
    resources/resources.qrc

TRANSLATIONS = \
    i18n/space-inspector_de.ts \
    i18n/space-inspector_es.ts \
    i18n/space-inspector_sv.ts
lupdate_only {
SOURCES += \
    qml/pages/*.qml \
    qml/components/*.qml
}

DISTFILES += \
    i18n/space-inspector_de.ts \
    i18n/space-inspector_es.ts \
    i18n/space-inspector_sv.ts

