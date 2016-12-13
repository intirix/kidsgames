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
        source: "tree1.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Column {
        anchors.left: parent.left
        anchors.top: backButton.bottom
        anchors.topMargin: ballSize/2


        DraggableItem {
            area: area
            source: "red_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "purple_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "green_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "gold_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "blue_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "pink_ball.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
    }


    DraggableItemArea {
        id: area
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

}

