import QtQuick 2.7
import "qrc:/components"

Rectangle {
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int baseAnimalSize: squareSize/4

    property int startMinX: 0
    property int startMinY: backButton.height
    property int startMaxX: parent.width
    property int startMaxY: parent.height / 2

    DraggableItem {
        source: "qrc:/images/animals/whale.svg"
        area: area
        size: baseAnimalSize
        Component.onCompleted: {
            moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
        }
    }
    DraggableItem {
        source: "qrc:/images/animals/elephant.svg"
        area: area
        size: baseAnimalSize
        Component.onCompleted: {
            moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
        }
    }
    DraggableItem {
        source: "fish.svg"
        area: area
        size: baseAnimalSize
        Component.onCompleted: {
            moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
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

