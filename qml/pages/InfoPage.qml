/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 - 2018 Jens Klingen

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

import "../components"

Page {
    id: page

    SilicaFlickable {
        id:sf
        anchors.fill: parent
        contentHeight: childRect.height

        Rectangle {
            id:childRect
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            width:parent.width
            height:childrenRect.height
            color:'transparent'

            PageHeader {
                id: title
                title: 'Space Inspector'
            }

            Image {
                id: logo
                y: Theme.paddingLarge
                anchors.top: title.bottom
                anchors.left: title.left
                anchors.leftMargin: Theme.paddingLarge
                source: 'qrc:/img/harbour-space-inspector.png'
                width: 86
                height: 86
            }
            Label {
                id: copyright
                anchors.top: logo.top
                anchors.right: title.right
                anchors.rightMargin: Theme.paddingLarge
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignRight
                text: '<strong>' + qsTr('Version %1').arg('0.7') + '</strong><br>' +  qsTr("Copyright © %2<br>Jens Klingen").arg('2014 - 2018')
                color:Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
            }

            Column {
                anchors.top: copyright.bottom
                anchors.left: logo.left
                anchors.right: copyright.right
                spacing: Theme.paddingSmall

                Spacer {}
                Label {
                    width:parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    font.bold: true
                    color: Theme.highlightColor
                    text: qsTr("No matter how much storage you have got - it will be full.")
                }
                Label {
                    width:parent.width
                    anchors.margins: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    color: Theme.highlightColor
                    text: qsTr("Space Inspector helps to find large folders and files on your storage.")
                }

                Spacer {}
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    font.bold: true
                    color: Theme.highlightColor
                    text: qsTr("Questions, problems, suggestions?")
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text: 'Github'
                        onClicked: Qt.openUrlExternally("https://github.com/jklingen/space-inspector/issues");
                    }
                    Spacer {}
                    Button {
                        text: 'Twitter'
                        onClicked: Qt.openUrlExternally("https://twitter.com/jklingen");
                    }
                }

                Spacer {}
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    font.bold: true
                    color: Theme.highlightColor
                    text: qsTr("Do you like this app?")
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr('Buy me a beer :)')
                    onClicked: {
                        Qt.openUrlExternally("https://www.paypal.me/jklingen/3");
                        text = qsTr('Cheers!')
                    }
                }

                Spacer {}
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    font.bold: true
                    color: Theme.highlightColor
                    text: qsTr("Free & open source!")
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr('GPL version 3')
                    onClicked: Qt.openUrlExternally("http://www.gnu.org/licenses/gpl-3.0.txt");
                }

                Spacer {}
                Label {
                    width:parent.width
                    anchors.margins: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    textFormat: Text.RichText
                    onLinkActivated: function(url) {Qt.openUrlExternally(url)}
                    //: If wanted, add translator info in your language, e.g. "English translation by <a href=\"https://github.com/jklingen/\">Jens Klingen</a>"
                    text: '<style>a:link { color: ' + Theme.primaryColor + '; }</style>' +
                        qsTr("[Translator credit]") + ""
                    visible:
                        text.length > 0 && text.indexOf("[Translator credit]") == -1
                }
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    width:parent.width
                    font.pixelSize: Theme.fontSizeSmall
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    onLinkActivated: function(url) {Qt.openUrlExternally(url)}
                    color: Theme.secondaryHighlightColor
                    text: '<style>a:link { color: ' + Theme.primaryColor + '; }</style>' +
                        qsTr('%1 charting implementation by Imran Ghory. Also, thanks to Kari for the excellent work on %2.')
                            .arg('<a href="https://github.com/imranghory/treemap-squared">Treemap Squared</a>')
                            .arg('<a href="https://github.com/karip/harbour-file-browser">File Browser</a>')
                }
                Spacer {}
            }
        }
    }
}
