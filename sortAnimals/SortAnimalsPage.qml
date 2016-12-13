import QtQuick 2.7
import "qrc:/components"

Rectangle {
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int baseAnimalSize: squareSize/4

    DraggableItem {
        id: sprite1
        source: "qrc:/images/animals/whale.svg"
        size: baseAnimalSize
    }

    DraggableItemArea {
        items: [ sprite1 ]
    }
}

