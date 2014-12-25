/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 Jens Klingen

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

        PageHeader {
            id: title
            title: qsTr('About')
        }

        Image {
            id: logo
            anchors.top: title.bottom
            x: Theme.paddingLarge
            source: 'qrc:/img/harbour-space-inspector.png'
            width: 86
            height: 86
        }

        Label {
            id: appName
            anchors.top: logo.top
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignRight
            textFormat: Text.RichText
            text: "Space Inspector"
            color:Theme.highlightColor
            font.pixelSize: Theme.fontSizeLarge
        }

        Label {
            id: copyRight
            anchors.top: appName.bottom
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignRight
            textFormat: Text.RichText
            text: '<strong>' + qsTr('Version %1').arg('0.5') + '</strong><br>' +  qsTr("Copyright © %2 Jens Klingen").arg('2014')
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeSmall
        }
        Label {
            id: intro
            anchors.top: copyRight.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.paddingLarge
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            color: Theme.highlightColor
            text: qsTr("No matter how much storage\nyou’ve got — it will be full.")
        }

        Label {
            id: description
            anchors.top: intro.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.paddingLarge
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            color: Theme.highlightColor
            text: qsTr("Space Inspector helps to find large folders and files on your storage.")
        }

        Label {
            id: feedback
            anchors.top: description.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.paddingLarge
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            color: Theme.highlightColor
            text: qsTr("Questions, problems, suggestions?")
        }

        Button {
            id: github
            anchors.top: feedback.bottom
            anchors.right: parent.horizontalCenter
            text: 'Github'
            onClicked: Qt.openUrlExternally("https://github.com/jklingen/space-inspector/issues");
        }

        Button {
            id: twitter
            anchors.top: feedback.bottom
            anchors.left: parent.horizontalCenter
            text: 'Twitter'
            onClicked: Qt.openUrlExternally("https://twitter.com/jklingen");
        }


        Label {
            id: license
            anchors.top: github.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.paddingLarge
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            color: Theme.highlightColor
            text: qsTr("Free & open source!")
        }



        Button {
            id:gpl
            anchors.top: license.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr('GPL version 3')
            onClicked: Qt.openUrlExternally("http://www.gnu.org/licenses/gpl-3.0.txt");
        }

        Label {
            id:misc
            anchors.top: gpl.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.paddingLarge
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
    }}

}
