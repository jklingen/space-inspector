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

import "../js/treemap-squarify.js" as Tm
import "../js/Util.js" as Util
import "../js/Memory.js" as Memory


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
                text: "List view"
                onClicked: {
                    pageStack.replace("../pages/ListPage.qml",{nodeModel:nodeModel})
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

        Rectangle {
            id: treeMap
            anchors.top:title.bottom
            width: parent.width - 1
            height: parent.height - title.height
            color:'transparent'
        }
    }

    NotificationPanel {
        id: notificationPanel
        page: page
    }


    ShellConnector {}

    Connections {
        target: engine
        onWorkerErrorOccurred: {
            console.log("FileWorker error: ", message, filename);
            notificationPanel.showTextWithTimer("An error occurred", message);
        }
        onFileDeleted: {
            refreshPage();
        }
    }

    function displayDirectoryList(subNodesWithSize) {

        var sizeArr = [];
        for(var i in subNodesWithSize) {
            sizeArr.push(subNodesWithSize[i].size);
        }
        var coords = Tm.Treemap.generate(sizeArr, treeMap.width, treeMap.height);
        var nodeComponent = Qt.createComponent('../components/TreeMapNode.qml');
        for(var i in coords) {
            var coord = coords[i];
            if(nodeComponent.status === Component.Ready) {
                var nodeConfig = {
                    nodeModel: subNodesWithSize[i],
                    nodeLeft: coord[0] + 1,
                    nodeTop: coord[1] + 1,
                    nodeWidth: coord[2] - coord[0] - 1,
                    nodeHeight: coord[3] - coord[1] - 1

                };
                nodeComponent.createObject(treeMap, nodeConfig);
            }
        }
        busyIndicator.running = false;
        busyIndicator.visible = false;

    }

    function createNodeModel() {
        return {dir:'/', isDir:true, size: 0}
    }

    function refreshPage() {
        if(pageStack.currentPage === page && !pageStack.busy) {
            pageStack.replace("../pages/TreeMapPage.qml",{nodeModel:pageStack.currentPage.nodeModel})
        }
    }


}


