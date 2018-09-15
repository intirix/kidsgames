import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: me
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)

    BackButton {
        id: backButton
        stackRef: stack
    }

    Image {
        id: restartButton
        source: "/images/restart.png"
        width: backButton.buttonSize
        height: backButton.buttonSize
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: restart();
        }
    }


    Text {
        id: textViewFormula
        color: "#ffffff"
        text: "x + _ = 10"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 3 / 10
        }
    }














    Component.onCompleted: {
        restart();
    }

    function restart() {
        var left = parseInt(Math.random() * 10 );
        if (left<1) {
            left = 1;
        }

        textViewFormula.text = left + " + _ = 10";
    }

}
