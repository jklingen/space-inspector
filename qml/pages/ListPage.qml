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
import "../js/IoTranslator.js" as IoTranslator
import "../js/Util.js" as Util



Page {
    id: page

    property var nodeModel: createNodeModel()

    SilicaFlickable {
        id:sf
        anchors.fill: parent
        contentHeight: parent.height

        GlobalPushUpMenu {}


        PullDownMenu {
            MenuItem {
                text: "Box view"
                onClicked: {
                    pageStack.replace("../pages/TreeMapPage.qml",{nodeModel:nodeModel})
                }
            }
        }

        PageHeader {
            id: title
            title: Util.getNodeNameFromPath(nodeModel.dir) + ' (' + Util.getHumanReadableSize(nodeModel.size) + ')'
        }

        ActivityIndicator {
            id: busyIndicator
            anchors.fill:parent
        }

        ListModel {
            id:subDirsModel
        }

        SilicaListView {
            id: listView
            anchors.fill: parent
            anchors.topMargin: title.height + Theme.paddingSmall
            VerticalScrollDecorator {}
            model: subDirsModel
            delegate: subDirsDelegate
        }

        Component {
            id:subDirsDelegate
            Rectangle {

                id: itemDelegate
                anchors.left: parent.left
                width: parent.width
                height: Theme.itemSizeSmall
                color: mArea.pressed ? Theme.secondaryHighlightColor : "transparent"

                Label {
                    id: dirName
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingLarge
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: Util.getNodeNameFromPath(model.dir);
                    color: mArea.pressed || !model.isDir ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    id: dirSize
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: model.size
                    color: mArea.pressed || !model.isDir ? Theme.highlightColor : Theme.primaryColor
                }

                MouseArea {
                    id: mArea
                    anchors.fill: itemDelegate
                    enabled: model.isDir
                    onClicked: {
                        pageStack.push("ListPage.qml",{nodeModel:model})
                    }
                }
            }
        }
     }

    ShellConnector {}

    function displayDirectoryList(subNodesWithSize) {

        for(var i=0; i<subNodesWithSize.length; i++) {
            subDirsModel.append(subNodesWithSize[i]);
        }

        busyIndicator.running = false;
        busyIndicator.visible = false;

    }

    function createNodeModel() {
        return {dir:'/', isDir:true}
    }
}


