import QtQuick 2.0

Item {

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12

    width: buttonSize
    height: buttonSize

    Image {
        id: icon
        anchors.fill: parent;
        source: "/images/info.png"
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            console.log("Loading info page");
            stack.push(Qt.resolvedUrl("qrc:/InfoPage.qml"));
        }
    }
}
