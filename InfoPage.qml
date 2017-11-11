import QtQuick 2.7
import QtQuick.Controls 1.4
import "qrc:/components"

Rectangle {
    id: page
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)

    ListModel {
        id: model
    }

    ListView {
        id: list
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: model
        delegate: Text {
            text: label+"\n";
            color: "white"
        }
    }

    Component.onCompleted: {
        model.clear();
        var items = credits.split("\n\n");
        for (var i = 0; i < items.length; i++ ) {
            console.log(items[i]);
            model.append({"label":items[i]});
        }
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

}
