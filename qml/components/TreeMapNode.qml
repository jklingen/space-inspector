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
import "../js/Util.js" as Util

Rectangle {

    property var nodeModel

    color: 'transparent'

    Rectangle {
        anchors.fill: parent
        color: Theme.secondaryHighlightColor
        opacity:mArea.pressed ? 1 : (nodeModel && nodeModel.isDir ? 0.5 : 0.25);
    }

    Label{
        id: label
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: mArea.pressed || (nodeModel && nodeModel.isDir) ? Theme.highlightColor : Theme.primaryColor
        text: Util.getNodeNameFromPath(nodeModel.dir) + '\n' + Util.getHumanReadableSize(nodeModel.size)
        // try to optimize text display for smaller rectangles...
        onPaintedWidthChanged: {
            if(paintedWidth > parent.width) font.pixelSize = Math.floor(font.pixelSize * parent.width / paintedWidth);
            if(paintedHeight > parent.height) text = Util.getNodeNameFromPath(nodeModel.dir);
        }
        // ... if too small, rather display no text
        visible:parent.width > 30 && parent.height > 30
    }

    MouseArea {
        id: mArea
        anchors.fill: parent
        enabled: nodeModel.isDir
        onClicked: {
            pageStack.push("../pages/TreeMapPage.qml",{nodeModel:nodeModel})
        }
        /*onPressAndHold: {
            console.log('hold')
        }*/
    }
}
