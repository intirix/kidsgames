import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    objectName: "SightShapes"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property string currentText: "\u25A0"

    property var letterList: [
        ["\u25A0","\u25AC","\u25B2","\u25CF"]
    ]

    color: "#000000"

    function randomText() {
        var list = letterList[0];
        var rnum = Math.floor(Math.random() * list.length);
        return list[rnum];
    }

    function setText(txt) {
        currentText = txt;
    }

    Text {
        id: textView
        color: "#ffffff"
        text: currentText
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 8 / 10
        }

        Component.onCompleted: {
            setText(randomText());
        }
    }

    BackButton {
        stackRef: stack
    }

    Image {
        id: randomButton
        source: "/images/random.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: {
                setText(randomText());
            }
        }
    }

}
