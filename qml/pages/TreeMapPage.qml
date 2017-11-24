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

import "../js/treemap-squarify.js" as Tm
import "../js/Util.js" as Util
import "../js/Memory.js" as Memory

Page {
    id: page

    property var nodeModel: createNodeModel()
    property var collapsedSubNodePaths: []
    property int collapsedSubNodesSize: 0
    property var subNodesWithSize: []

    SilicaFlickable {
        id:sf
        anchors.fill: parent
        contentHeight: parent.height

        GlobalPushUpMenu {}

        PullDownMenu {
            MenuItem {
                text: qsTr("Go to...")
                onClicked: {
                    pageStack.push("../pages/PlacesPage.qml",{nodeModel:nodeModel})
                }
            }
            MenuItem {
                text: qsTr("Refresh")
                onClicked: {
                    refreshPage()
                }
            }
            MenuItem {
                text: qsTr("List view")
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

        TreeMapNodeCollapsed {
            id: collapsedNodes
            anchors.top: title.bottom
            x: 1
            width: parent.width - 2
            collapsedNodePaths: collapsedSubNodePaths
            collapsedNodesSize: collapsedSubNodesSize

            onClick: {
                collapsedSubNodePaths = [];
                renderTreeMap();
            }
        }

        Rectangle {
            id: treeMap
            anchors.top:collapsedNodes.bottom
            width: parent.width - 1
            height: parent.height - title.height - collapsedNodes.height
            color:'transparent'

            function clear() {
                for(var i=children.length-1; i>=0; i--) {
                    children[i].destroy();
                }
            }
        }
    }

    NotificationPanel {
        id: notificationPanel
        page: page
    }


    ShellConnector {
        id:shellConnector
    }

    Connections {
        target: engine
        onWorkerErrorOccurred: {
            console.log("FileWorker error: ", message, filename);
            notificationPanel.showTextWithTimer(qsTr("An error occurred"), message);
        }
        onFileDeleted: {
            refreshPage();
        }
    }

    function displayDirectoryList(nodesWithSize) {
        subNodesWithSize = nodesWithSize;
        renderTreeMap();
    }

    function collapseSubNode(nodePath) {
        var sn = null;
        for(var i=0; i<subNodesWithSize.length; i++) {
            sn = subNodesWithSize[i];
            if(sn.dir === nodePath) {
                collapsedSubNodePaths.push(sn.dir);
                renderTreeMap();
                break;
            }
        }
    }

    function renderTreeMap() {
        treeMap.clear();

        var visibleNodesWithSize = removeCollapsed(subNodesWithSize);

        var sizeArr = [];
        for(var i in visibleNodesWithSize) {
            sizeArr.push(visibleNodesWithSize[i].size);
        }
        var coords = Tm.Treemap.generate(sizeArr, treeMap.width, treeMap.height);
        var nodeComponent = Qt.createComponent('../components/TreeMapNode.qml');
        for(var i in coords) {
            var coord = coords[i];
            if(nodeComponent.status === Component.Ready) {
                var nodeConfig = {
                    nodeModel: visibleNodesWithSize[i],
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

    function removeCollapsed(nodesWithSize) {
        collapsedSubNodesSize = 0;
        var ret = [];
        for(var i=0; i<nodesWithSize.length; i++) {
            var node = nodesWithSize[i];
            var dir = node.dir;
            if(collapsedSubNodePaths.indexOf(dir)<0) {
                ret.push(node);
            } else {
                collapsedSubNodesSize += node.size;
            }
        }
        return ret;
    }

    function createNodeModel() {
        return {dir:engine.homeFolder(), isDir:true, size: 0}
    }

    function refreshPage() {
        shellConnector.refresh();
        renderTreeMap();
    }


}


