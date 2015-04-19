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

MouseArea {

    property string path
    property string text
    property string targetPageQml: "../pages/TreeMapPage.qml"

    width: parent.width
    height: lbl.height + Theme.paddingLarge * 2


    onClicked: pageStack.push(targetPageQml,{nodeModel:{dir:path,isDir:true, size:0}})

    Image {
        id: image
        source: 'image://theme/icon-m-folder'
        x: Theme.paddingLarge
        anchors.verticalCenter: parent.verticalCenter
        height:lbl.height
        fillMode: Image.PreserveAspectFit
        opacity: parent.enabled ? 1.0 : 0.4
    }


    Label {
        id:lbl
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: image.right
        anchors.leftMargin: Theme.paddingMedium
        color: parent.pressed ? Theme.highlightColor : Theme.primaryColor
        text: parent.text
    }

    Rectangle {
        width:parent.width
        height:parent.height
        color:Theme.secondaryHighlightColor
        opacity: parent.pressed ? .25 : 0
    }

}
