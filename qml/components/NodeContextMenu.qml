import QtQuick 2.0

import Sailfish.Silica 1.0
import "../js/Util.js" as Util

ContextMenu {
    id:contextMenu
    property var nodeModel
    property Item remorseItem
    property bool listViewMode: false
    signal collapseClicked;

    MenuItem {
        text: "Collapse " + Util.getNodeNameFromPath(nodeModel.dir)
        visible:!listViewMode
        onClicked: {
            collapseClicked();
        }
    }

    MenuItem {
        text: "Open " + Util.getNodeNameFromPath(nodeModel.dir)
        onClicked: {
            console.log("Trying to open file://" + nodeModel.dir)
            Qt.openUrlExternally("file://" + nodeModel.dir);
        }
        visible: !(nodeModel.isDir)
        enabled: Util.canHandleFile(nodeModel.dir)
    }

    MenuItem {
        text: "Delete " + Util.getNodeNameFromPath(nodeModel.dir)
        onClicked: {
            var dialog = pageStack.push("../pages/DeleteDialog.qml",{nodeModel:nodeModel})
            dialog.accepted.connect(onDialogAccepted);
        }
        function onDialogAccepted(){
            if(listViewMode) {
                remorseItem.execute(remorseItem.parent, "Delete " + Util.getNodeNameFromPath(nodeModel.dir), function(){
                    console.log("Deleting " + nodeModel.dir)
                    engine.deleteFiles(nodeModel.dir)
                    //pageStack.replace("../pages/ListPage.qml",{nodeModel:pageStack.currentPage.nodeModel})
                });
            } else {
                remorseItem.execute("Delete " + Util.getNodeNameFromPath(nodeModel.dir), function(){
                    console.log("Deleting " + nodeModel.dir)
                    engine.deleteFiles(nodeModel.dir)
                    //pageStack.replace("../pages/TreeMapPage.qml",{nodeModel:pageStack.currentPage.nodeModel})
                });
            }
        }
    }


}
