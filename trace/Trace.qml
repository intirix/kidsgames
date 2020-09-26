import QtQuick 2.7
import QtMultimedia 5.7
import "qrc:/components"
import KidGames 1.0

Rectangle {
    id: page
    objectName: "Trace"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property string traceText: "M"

    color: "#000000"

    SoundClip {
        id: howToClipUpper;
        qrcPath: ":/trace/howto-trace.ogg";
    }

    SoundClip {
        id: howToClipLower;
        qrcPath: ":/trace/howto-trace-lower.ogg";
    }

    SoundClip {
        id: howToClipNumber;
        qrcPath: ":/trace/howto-trace-numbers.ogg";
    }

    Storage {
        id: storage
    }


    state: storage.getItem("pages.traceLetters.mode","UPPER");

    states: [
        State {
            name: "UPPER"
        },
        State {
            name: "LOWER"
        },
        State {
            name: "NUMBER"
        }
    ]

    function randomLetter() {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var nums = "0123456789";
        if (page.state==="NUMBER") {
            var rnum = Math.floor(Math.random() * nums.length);
            var ch = nums.substring(rnum,rnum+1);
            console.log("Choosing letter '"+ch+"', number "+rnum);
            return ch;
        } else {
            rnum = Math.floor(Math.random() * chars.length);
            ch = chars.substring(rnum,rnum+1);
            console.log("Choosing letter '"+ch+"', number "+rnum);
            return ch;
        }
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
            text: ( page.state == "UPPER" ? "\u2191" : ( page.state == "NUMBER" ? "7" : "\u2193" ) )
            color: textView.color
            font {
                pixelSize: buttonSize * 9 / 10
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (page.state==="UPPER") {
                    page.state = "LOWER";
                } else if (page.state=="LOWER") {
                    page.state = "NUMBER";
                    clearLines();
                    setText(randomLetter());
                } else {
                    page.state = "UPPER";
                    clearLines();
                    setText(randomLetter());
                }
                storage.setItem("pages.traceLetters.mode",page.state);
                playHowto();
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

    Component.onCompleted: {
        playHowto();
    }

    function playHowto() {
        if (page.state==="UPPER") {
            howToClipUpper.play();
        } else if (page.state=="LOWER") {
            howToClipLower.play();
        } else {
            howToClipNumber.play();
        }
    }
}
