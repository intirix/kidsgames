import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    objectName: "SightWords"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property string currentWord: "RAN"

    property var wordParts: ["AN","ID","ET"];
    property var wordList: {
        "AN": ["R","B","P","M","T","F","C","V"],
        "ID": ["D","R","L","B"],
        "ET": ["G","W","P","S","L","V","B","M"]
    }

    property int currentPartIndex: 0;
    property string currentPart: wordParts[currentPartIndex];

    color: "#000000"

    function randomWord() {
        var list = wordList[currentPart];
        var rnum = Math.floor(Math.random() * list.length);
        return list[rnum]+currentPart.toLowerCase();
    }

    function setText(txt) {
        currentWord = txt;
    }

    SoundClip {
        id: howToClip;
        qrcPath: ":/reading/howto-similar.ogg";
        playOnLoad: true;
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


    Rectangle {
        id: partButton
        width: buttonSize
        height: buttonSize

        anchors.bottom: parent.bottom
        anchors.right: randomButton.left
        anchors.rightMargin: buttonSize / 4;
        color: "transparent"
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: currentPart;
            color: textView.color
            font {
                pixelSize: buttonSize * 9 / 10
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {

                if (currentPartIndex+1>=wordParts.length) {
                    currentPartIndex = 0;
                } else {
                    currentPartIndex++;
                }
                currentPart = wordParts[currentPartIndex];

                setText(randomWord());
            }
        }
    }


}
