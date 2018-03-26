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
import harbour.space.inspector.shell 1.0
import "../js/IoTranslator.js" as IoTranslator
import "../js/Util.js" as Util

CoverBackground {

    property var fileSystemInfo

    Label {
        id: label
        font.pixelSize: Theme.fontSizeLarge
        horizontalAlignment: Text.AlignHCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Theme.paddingLarge
        wrapMode: Text.WordWrap
        text: getLabelText()
    }

    Image {
        source: 'qrc:/img//cover.png'
        anchors.horizontalCenter: parent.horizontalCenter
        y:Theme.paddingSmall
        width: parent.width - 2 * Theme.paddingSmall
        height: sourceSize.height * width / sourceSize.width
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                refresh();
            }
        }
    }

    function getLabelText() {
        return fileSystemInfo
                ? qsTr('%1 \n used of \n %2 \n (%3)').arg(fileSystemInfo.Used).arg(fileSystemInfo.Size).arg(fileSystemInfo['Use%'])
                  : 'Space\nInspector';
    }

    function refresh() {
        fileSysShell.execute();
    }

    Shell {
        id:fileSysShell
        command:IoTranslator.FileSysInfo.getCommand('/')
        onExecuted: {
            fileSystemInfo = IoTranslator.FileSysInfo.parseResult(response);
        }
    }

    Timer {
        running: true
        interval: 5000
        onTriggered: {
            fileSysShell.execute();
        }
    }

}


