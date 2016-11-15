import QtQuick 2.7
import "qrc:/"
import "qrc:/components"

Rectangle {
    id: page
    objectName: "DrawPage"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12

    color: "#000000"

    function setDrawColor(c) {
        freeDraw.setDrawColor(c);
    }

    function clearLines() {
        freeDraw.clearLines();
    }

    FreeDraw {
        id: freeDraw
        lineWidth: squareSize / 200
    }

    BackButton {
        stackRef: stack
    }

    Image {
        id: restartButton
        source: "/images/restart.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: clearLines();
        }
    }

    Image {
        id: colorButton
        source: "/images/colors.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: restartButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("/ColorSelect.qml"))
            }
        }
    }

}
