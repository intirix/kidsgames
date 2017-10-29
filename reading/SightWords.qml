import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    objectName: "SightWords"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property string currentWord: "M"

    property var wordList: [
        "a, and, away, big, blue, can, come, down, find, for, funny, go, help, here, I, in, is, it, jump, little, look, make, me, my, not, one, play, red, run, said, see, the, three, to, two, up, we, where, yellow, you"
    ]

    color: "#000000"

    function randomWord() {
        var list = wordList[0].split(", ");
        var rnum = Math.floor(Math.random() * list.length);
        return list[rnum];
    }

    function setText(txt) {
        currentWord = txt;
    }

    Text {
        id: textView
        color: "#ffffff"
        text: currentWord
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 3 / 10
        }

        Component.onCompleted: {
            setText(randomWord());
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
                setText(randomWord());
            }
        }
    }

}
