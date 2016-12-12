import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int treeSize: squareSize * 8 / 10;
    property int ballSize: squareSize * 1 / 10;

    Image {
        height: treeSize
        source: "qrc:/christmasTree/tree1.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Column {
        anchors.left: parent.left
        anchors.top: backButton.bottom


        DraggableItem {
            id: sprite1
            source: "red_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            id: sprite2
            source: "purple_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
    }


    DraggableItemArea {
        items: [ sprite1, sprite2 ]
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

}

