import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    objectName: "Trace"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property string traceText: "M"

    color: "#000000"

    state: "UPPER"

    states: [
        State {
            name: "UPPER"
        },
        State {
            name: "LOWER"
        }
    ]

    function randomLetter() {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var rnum = Math.floor(Math.random() * chars.length);
        var ch = chars.substring(rnum,rnum+1);
        console.log("Choosing letter '"+ch+"', number "+rnum);
        return ch;
    }

    function setText(txt) {
        traceText = txt;
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
        text: ( page.state == "UPPER" ? traceText.toUpperCase() : traceText.toLowerCase() )
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 9 / 10
        }

        Component.onCompleted: {
            setText(randomLetter());
        }
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
                setText(randomLetter());
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
                stack.push({item:Qt.resolvedUrl("TraceSelect.qml"),properties: {"lettercase":page.state}});
            }
        }
    }

    Rectangle {
        id: caseButton
        width: buttonSize
        height: buttonSize

        anchors.bottom: parent.bottom
        anchors.right: selectButton.left
        color: "transparent"
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: ( page.state == "UPPER" ? "\u2193" : "\u2191" )
            color: textView.color
            font {
                pixelSize: buttonSize * 9 / 10
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                page.state = ( page.state == "UPPER" ? "LOWER" : "UPPER" );
            }
        }
    }

    Image {
        id: colorButton
        source: "/images/colors.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: caseButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("/components/ColorSelect.qml"))
            }
        }
    }


}
