import QtQuick 2.7
import "qrc:/components"

Rectangle {
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int treeSize: squareSize * 8 / 10;

    Image {
        height: treeSize
        source: "qrc:/christmasTree/tree1.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    DraggableItem {
        id: sprite1
        size: baseAnimalSize
    }

    DraggableItemArea {
        items: [ sprite1 ]
    }

    BackButton {
        stackRef: stack
    }

}

