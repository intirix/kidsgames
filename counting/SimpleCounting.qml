import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: me
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int baseAnimalSize: squareSize/8

    property int startMinX: 0
    property int startMinY: backButton.height
    property int startMaxX: parent.width
    property int startMaxY: parent.height / 2

    property var animals: []
    property int max: 20
    property int total: 10
    property var numVisible: parseInt(Math.random() * total)

    property var images: [
        "qrc:/images/animals/elephant.svg",
        "qrc:/sortAnimals/dog.svg",
        "qrc:/sortAnimals/turtle.svg",
    ]

    SoundClip {
        id: howToClip;
        qrcPath: ":/counting/howto-counting.ogg";
        playOnLoad: true;
    }

    Item {
        anchors.top: parent.top
        anchors.bottom: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        DraggableItemArea {
            id: area
        }
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
            onClicked: restart();
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < max; i++) {
            var component = Qt.createComponent("qrc:/components/DraggableItem.qml");
            var obj = component.createObject(me, {"size": baseAnimalSize, "area": area, "source": "qrc:/images/animals/elephant.svg", "cloneItem": false});
            //obj.moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
            animals.push(obj);

        }
        restart();
    }

    function restart() {
        numVisible = parseInt(Math.random() * total )
        for (var i = 0; i < max; i++) {
            var obj = animals[i];
            obj.moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
            var url = images[parseInt(Math.random() * images.length)];
            obj.source = url;
            if (i < numVisible) {
                obj.visible = true;
            } else {
                obj.visible = false;
            }
        }
    }
}
