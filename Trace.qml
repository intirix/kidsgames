import QtQuick 2.7

Rectangle {
    id: page
    objectName: "Trace"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12

    color: "#000000"

    function randomLetter() {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var rnum = Math.floor(Math.random() * chars.length);
        var ch = chars.substring(rnum,rnum+1);
        console.log("Choosing letter '"+ch+"', number "+rnum);
        return ch;
    }

    function setText(txt) {
        textView.text = txt;
    }

    function setDrawColor(c) {
        freeDraw.setDrawColor(c);
    }

    function clearLines() {
        freeDraw.clearLines();
    }

    Text {
        id: textView
        color: "#ffffff"
        text: "M"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 9 / 10
        }

        Component.onCompleted: {
            text = randomLetter();
        }
    }

    FreeDraw {
        id: freeDraw
        lineWidth: squareSize / 200
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
        id: randomButton
        source: "/images/random.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: restartButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                clearLines();
                textView.text = randomLetter();
            }
        }
    }

    Rectangle {
        id: selectButton
        width: buttonSize
        height: buttonSize

        anchors.bottom: parent.bottom
        anchors.right: randomButton.left
        color: "transparent"
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "A"
            color: textView.color
            font {
                pixelSize: buttonSize * 9 / 10
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("TraceSelect.qml"))
            }
        }
    }

    Image {
        id: colorButton
        source: "/images/colors.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: selectButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("ColorSelect.qml"))
            }
        }
    }


}
