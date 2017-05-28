import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: me
    color: "#000000"

    Image {
        source: "beach.svg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }

    property int squareSize: Math.min(parent.height,parent.width)
    property int baseAnimalSize: squareSize/4

    property int startMinX: 0
    property int startMinY: backButton.height
    property int startMaxX: parent.width
    property int startMaxY: parent.height / 2

    property var waterList: [
        {
            "image": "fish.svg"
        },
        {
            "image": "shark.svg"
        },
        {
            "image": "turtle.svg"
        },
        {
            "image": "octopus.svg"
        },
        {
            "image": "crocodile.svg"
        },
        {
            "image": "qrc:/images/animals/whale.svg"
        }

    ]

    property var landList: [
        {
            "image": "qrc:/images/animals/elephant.svg"
        },
        {
            "image": "cow.svg"
        },
        {
            "image": "giraffe.svg"
        },
        {
            "image": "dog.svg"
        },
        {
            "image": "tiger.svg"
        },
        {
            "image": "lion.svg"
        },
        {
            "image": "monkey.svg"
        },
        {
            "image": "zebra.svg"
        },
        {
            "image": "horse.svg"
        }
    ]

    property var animals: []

    function handleDrop(item, list) {
        var matched = false;
        var filename2 = item.source.toString().replace(/.*\//,"");
        for (var i = 0; i < list.length; i++) {
            var animal = list[ i ];
            var filename1 = animal.image.replace(/.*\//,"");
            if (filename1 === filename2) {
                matched = true;
            }
        }
        if (matched) {
            console.log("Correctly dropped "+filename2);
            item.visible = false;
        } else {
            console.log("Incorrectly dropped "+filename2);
        }

    }

    DraggableItemDestination {
        area: area
        anchors.right: parent.horizontalCenter
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.verticalCenter

        onItemReleased: {
            handleDrop(item, waterList);
        }
    }

    DraggableItemDestination {
        area: area
        anchors.right: parent.right
        anchors.left: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.top: parent.verticalCenter

        onItemReleased: {
            handleDrop(item, landList);
        }
    }

    DraggableItemArea {
        id: area
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

    function restart() {
        for (var i = 0; i < animals.length; i++) {
            animals[ i ].moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
            animals[ i ].visible = true;
        }
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
        for (var i = 0; i < waterList.length; i++) {
            var animal = waterList[ i ];

            var component = Qt.createComponent("qrc:/components/DraggableItem.qml");
            var obj = component.createObject(me, {"size": baseAnimalSize, "area": area, "source": animal.image, "cloneItem": false});
            obj.moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
            animals.push(obj);
        }
        for (var i = 0; i < landList.length; i++) {
            var animal = landList[ i ];

            var component = Qt.createComponent("qrc:/components/DraggableItem.qml");
            var obj = component.createObject(me, {"size": baseAnimalSize, "area": area, "source": animal.image, "cloneItem": false});
            obj.moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
            animals.push(obj);
        }
    }
}

