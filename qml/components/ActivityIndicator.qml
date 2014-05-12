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

Item {

    property bool running:true

    Label {
        anchors.bottom:busyIndicator.top
        anchors.margins: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        width:busyIndicator.width
        horizontalAlignment: Text.AlignHCenter
        color:Theme.highlightColor
        text: 'Estimating\nspace usage.'
        font.pixelSize: Theme.fontSizeLarge
    }

    Label {
        anchors.top:busyIndicator.bottom
        anchors.margins: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        width:busyIndicator.width
        horizontalAlignment: Text.AlignHCenter
        color:Theme.highlightColor
        text: 'This might take\nsome seconds.'
        font.pixelSize: Theme.fontSizeLarge
    }

    BusyIndicator {
        id:busyIndicator
        anchors.centerIn: parent
        anchors.verticalCenterOffset: - Theme.paddingLarge
        y: -40
        size: BusyIndicatorSize.Large
        running:parent.running
    }

}
