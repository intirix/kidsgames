import QtQuick 2.7
import "qrc:/components"

Rectangle {
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int baseAnimalSize: squareSize/4

    DraggableItem {
        source: "qrc:/images/animals/whale.svg"
        area: area
        size: baseAnimalSize
    }
    DraggableItem {
        source: "qrc:/images/animals/elephant.svg"
        area: area
        size: baseAnimalSize
    }

    DraggableItemArea {
        id: area
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

}

