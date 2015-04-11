/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 - 2015 Jens Klingen

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
                anchors.bottom: logo.bottom
                anchors.right: title.right
                anchors.rightMargin: Theme.paddingLarge
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignRight
                text: '<strong>' + qsTr('Version %1').arg('0.6') + '</strong><br>' +  qsTr("Copyright © %2<br>Jens Klingen").arg('2014 - 2015')
                color:Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
            }

            Column {
                anchors.top:logo.bottom
                width:parent.width
                spacing:Theme.paddingSmall

                Spacer {}
                Label {
                    width:parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.bold: true
                    color: Theme.highlightColor
                    text: qsTr("No matter how much storage\nyou’ve got — it will be full.")
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
                        Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=paypal%40jklingen%2ecom&lc=US&item_name=Jens%20Klingen&no_note=0&cn=Message%20to%20Jens%3a&no_shipping=2&rm=1&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted&amount=3&item_name=A%20beer%20for%Space%20Inspector%20-%20cheers!");
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
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    width:parent.width
                    font.pixelSize: Theme.fontSizeSmall
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: Theme.secondaryHighlightColor
                    text: '<style>a:link { color: ' + Theme.primaryColor + '; }</style>' +
                        qsTr('%1 charting implementation by Imran Ghory. Also, thanks to Kari for the excellent work on %2.')
                            .arg('<a href="https://github.com/imranghory/treemap-squared">Treemap Squared</a>')
                            .arg('<a href="https://github.com/karip/harbour-file-browser">File Browser</a>')
                }
            }
        }
    }
}
