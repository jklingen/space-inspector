import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {

    property var nodeModel

    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingLarge
        anchors.rightMargin: Theme.paddingLarge
        spacing: Theme.paddingLarge

        DialogHeader {
            id: dialogHeader
            title: "Confirm delete"
            acceptText: nodeModel.isDir ? "Delete folder" : "Delete file"
        }

        Item {height: Theme.paddingLarge}

        Label {
            anchors.topMargin: Theme.paddingLarge
            text: "Do you really want to delete the following " + (nodeModel.isDir ? "folder?" : "file?")
            color: Theme.primaryColor
            width:parent.width
            wrapMode: Text.Wrap
        }
        Label {
            text: nodeModel.dir
            color: Theme.secondaryColor
            width:parent.width
            wrapMode: Text.Wrap
        }

        Item {
            width:parent.width
            height: Theme.paddingLarge
        }

        Label {
            text: "Always keep in mind: deleting things might break things, or even leave your phone in an unusable state. Use with caution."
            color: Theme.primaryColor
            width:parent.width
            wrapMode: Text.Wrap
        }
        Label {
            text: "Okay. I guess you already knew that...\nJust saying :)"
            color: Theme.secondaryColor
            width:parent.width
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.Wrap
        }
    }



}
