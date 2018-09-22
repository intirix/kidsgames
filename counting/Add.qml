import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: me
    color: "#000000"

    property int squareSize: Math.min(parent.height,parent.width)
    property int baseAnimalSize: squareSize/8

    property int maxAnimals: 7;

    property int startMinX: 0
    property int startMinY: backButton.height
    property int startMaxX: parent.width
    property int startMaxY: parent.height / 2


    property int startMinXL: 0
    property int startMinYL: backButton.height
    property int startMaxXL: parent.width
    property int startMaxYL: parent.height / 2


    property int startMinXR: rightBounds.x;
    property int startMinYR: backButton.height
    property int startMaxXR: parent.width
    property int startMaxYR: parent.height / 2


    property var images: [
        "qrc:/images/animals/elephant.svg",
        "qrc:/sortAnimals/dog.svg",
        "qrc:/sortAnimals/turtle.svg",
    ]

    property var animals: []


    Storage {
        id: storage
    }

    Item {
        width: parent.width;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom;
        DraggableItemArea {
            id: area
            onObjectReleased: updateCountEquation();
        }
    }

    BackButton {
        id: backButton
        stackRef: stack
    }


    Item {
        id: countingArea
        anchors.top: me.top
        anchors.bottom: me.bottom;
        anchors.left: me.left;
        anchors.right: me.right;
        anchors.leftMargin: backButton.buttonSize;
        anchors.rightMargin: backButton.buttonSize;
        anchors.topMargin: backButton.buttonSize;
        anchors.bottomMargin: backButton.buttonSize;

        Rectangle {
            color: "blue"
            id: leftBounds
            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.right: parent.horizontalCenter;
            anchors.bottomMargin: squareSize * 3 / 20
            anchors.rightMargin: squareSize * 1 / 20
        }
        Rectangle {
            color: "green"
            id: rightBounds
            anchors.left: parent.horizontalCenter;
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.right: parent.right;
            anchors.bottomMargin: squareSize * 3 / 20
            anchors.leftMargin: squareSize * 1 / 20
        }

        Text {
            color: "#ffffff";
            text: "+"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom;
            font {
                pixelSize: squareSize * 1 / 10
            }

        }
        Text {
            id: leftSum;
            color: "#ffffff";
            text: "0"
            anchors.horizontalCenter: leftBounds.horizontalCenter
            anchors.bottom: parent.bottom;
            font {
                pixelSize: squareSize * 1 / 10
            }

        }
        Text {
            id: rightSum;
            color: "#ffffff";
            text: "0"
            anchors.horizontalCenter: rightBounds.horizontalCenter
            anchors.bottom: parent.bottom;
            font {
                pixelSize: squareSize * 1 / 10
            }

        }


    }





    Rectangle {
        id: difficultyMenu
        color: "transparent"
        height: backButton.buttonSize
        width: difficultyMenuRow.width
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: height

        Row {
            id: difficultyMenuRow
            Image {
                source: "/counting/icon.png"
                width: backButton.buttonSize
                height: backButton.buttonSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: changeDifficulty("animals");
                }
            }
            Image {
                source: "/images/redorb/redorb-1.png"
                width: backButton.buttonSize
                height: backButton.buttonSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: changeDifficulty("simple");
                }
            }
            Image {
                source: "/images/redorb/redorb-2.png"
                width: backButton.buttonSize
                height: backButton.buttonSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: changeDifficulty("medium");
                }
            }
            Image {
                source: "/images/redorb/redorb-3.png"
                width: backButton.buttonSize
                height: backButton.buttonSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: changeDifficulty("hard");
                }
            }
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

    Image {
        id: difficultyButton
        source: "/counting/icon.png"
        width: backButton.buttonSize
        height: backButton.buttonSize
        anchors.bottom: parent.bottom
        anchors.right: restartButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: onDifficultyOpen();
        }
    }


    Text {
        id: textViewFormula
        visible: false;
        color: "#ffffff"
        text: "x + _ = 10"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 3 / 10
        }
    }












    Component.onCompleted: {
        var obj;
        var component;
        component = Qt.createComponent("qrc:/components/DraggableItem.qml");
        for (var i = 0; i < maxAnimals; i++) {
            obj = component.createObject(me, {"size": baseAnimalSize, "area": area, "source": "qrc:/images/animals/elephant.svg", "cloneItem": false});
            animals.push(obj);

        }



        restart();
    }

    function restart() {
        difficultyMenu.visible = false;
        var mode = storage.getItem("pages.add.mode","simple");
        console.log("mode="+mode);

        var left;
        var right;
        var visible;
        var obj;
        var i;
        var url;

        for (i = 0; i < maxAnimals; i++) {
            animals[i].visible = false;
        }

        if (mode==="simple") {
            textViewFormula.visible = true;
            countingArea.visible = false;
            difficultyButton.source = "qrc:/images/redorb/redorb-1.png";

            left = parseInt(Math.random() * 10 );
            if (left<1) {
                left = 1;
            }

            right = parseInt(Math.random() * (15 - left) );
            if (right<1||right>9) {
                right = 1;
            }
            textViewFormula.text = left + " + " + right + " =";
        } else if (mode==="medium") {
            textViewFormula.visible = true;
            countingArea.visible = false;
            difficultyButton.source = "qrc:/images/redorb/redorb-2.png";

            left = parseInt(Math.random() * 20 );
            if (left<1) {
                left = 1;
            }

            right = parseInt(Math.random() * (30 - left) );
            if (right<1||right>19) {
                right = 1;
            }
            textViewFormula.text = left + " + " + right + " =";
        } else if (mode==="hard") {
            textViewFormula.visible = true;
            countingArea.visible = false;
            difficultyButton.source = "qrc:/images/redorb/redorb-3.png";

            left = parseInt(Math.random() * 30 );
            if (left<1) {
                left = 1;
            }

            right = parseInt(Math.random() * (50 - left) );
            if (right<1||right>29) {
                right = 1;
            }
            textViewFormula.text = left + " + " + right + " =";
        } else if (mode==="animals") {
            textViewFormula.visible = false;
            countingArea.visible = true;
            difficultyButton.source = "qrc:/counting/icon.png";





            visible = parseInt(Math.random() * maxAnimals )
            var countLeft = 0;
            var countRight = 0;
            console.log("Visible: "+visible);

            for (i = 0; i < visible; i++) {
                obj = animals[i];
                obj.moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
                url = images[parseInt(Math.random() * images.length)];
                obj.source = url;
                obj.visible = true;
                if (obj.x<startMaxX/2) {
                    countLeft += 1;
                } else {
                    countRight += 1;
                }
            }

            leftSum.text = ""+countLeft;
            rightSum.text = ""+countRight;
            updateCountEquation();

        }


    }

    function updateCountEquation() {
        var countLeft = 0;
        var countRight = 0;

        for (var i = 0; i < maxAnimals; i++) {
            if (animals[i].visible) {
                if (animals[i].x<startMaxX/2) {
                    countLeft += 1;
                } else {
                    countRight += 1;
                }
            }
        }
        leftSum.text = ""+countLeft;
        rightSum.text = ""+countRight;

    }

    function onDifficultyOpen() {
        difficultyMenu.visible = !difficultyMenu.visible;
    }

    function changeDifficulty(mode) {
        difficultyMenu.visible = false;
        storage.setItem("pages.add.mode",mode);
        restart();
    }

}
