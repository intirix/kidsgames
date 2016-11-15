import QtQuick 2.0
import QtQuick.Controls 1.4

Item {

    property StackView stackRef;

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12

    width: buttonSize
    height: buttonSize

    Image {
        id: icon
        anchors.fill: parent;
        source: "/images/home.png"
    }

    Component.onCompleted: {
        if (stackRef.depth>2) {
            icon.source = "/images/back.png";
        }
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            stackRef.pop();
        }
    }
}
