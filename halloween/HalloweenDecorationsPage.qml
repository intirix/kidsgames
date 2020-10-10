import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int ballSize: squareSize * 1 / 10;

    property var backgrounds: ["background.jpg", "background-fullmoon.jpg", "background-forest.jpg"];
    property int selectedBackground: Math.floor(Math.random() * backgrounds.length);

    SoundClip {
        id: howToClip;
        qrcPath: ":/halloween/howto.ogg";
        playOnLoad: true;
    }

    Image {
        id: background;
        source: backgrounds[selectedBackground];
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }

    Column {
        anchors.left: parent.left
        anchors.top: backButton.bottom
        anchors.topMargin: ballSize/2


        DraggableItem {
            area: area
            source: "tombstone.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "pumpkin.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "spider.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "skull.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "witch.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "web.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
        DraggableItem {
            area: area
            source: "ghost.png"
            size: ballSize
            cloneItem: true
            cloneParent: page
        }
    }


    DraggableItemArea {
        id: area
    }

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
            onClicked: changeBackground();
        }
    }

    function changeBackground() {
        var idx = selectedBackground + 1;
        if (idx >= backgrounds.length) {
            idx = 0;
        }
        selectedBackground = idx;
    }
}

