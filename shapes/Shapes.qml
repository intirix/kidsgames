import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    objectName: "SightShapes"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property string currentText: "\u25A0"
    property string currentColor: "red"

    property var letterList: [
        ["\u25A0","\u25AC","\u25B2","\u25CF","\u2665","\u25C6"
         /* ellipse "\u2B2C"*/]
    ]

    property var colorList: [
        "#FF0000", "#FFFF00", "#0000FF", "#00FF00", "#FFA500", "#9400D3"
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

    function changeColor() {
        var rnum = Math.floor(Math.random() * colorList.length);
        currentColor = colorList[rnum];
    }

    SoundClip {
        id: howToClip;
        qrcPath: ":/shapes/howto.ogg";
        playOnLoad: true;
    }

    Text {
        id: textView
        color: currentColor
        text: currentText
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 8 / 10
        }

        Component.onCompleted: {
            setText(randomText());
            changeColor();
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
                changeColor();
            }
        }
    }

}
