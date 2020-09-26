import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    objectName: "Directions"

    property int squareSize: Math.min(parent.height,parent.width)
    property int rows: 10
    property int buttonSize: squareSize / 12
    property int gridItemSize: squareSize / ( rows + 1 )
    property color borderColor: "#FFFFFF"
    property int tokenX: 0
    property int tokenY: 0
    property int outsideBorder: 3
    property int insideBorder: 1
    color: "#000000"

    property var boxes: []

    SoundClip {
        id: howToClip;
        qrcPath: ":/arrows/howto.ogg";
        playOnLoad: true;
    }

    function goUp() {
        if (tokenY > 0) {
            tokenY--;
        }
    }

    function goDown() {
        if (tokenY < rows-1) {
            tokenY++;
        }
    }

    function goLeft() {
        if (tokenX > 0) {
            tokenX--;
        }
    }

    function goRight() {
        if (tokenX < ( rows - 4 ) ) {
            tokenX++;
        }
    }

    BackButton {
        stackRef: stack
    }

    Component {
        id: boxFactory
        Rectangle {
            width: gridItemSize
            height: gridItemSize
            color: "transparent"
            border.color: "#999999"
            border.width: insideBorder
        }
    }

    Rectangle {
        width: rows * gridItemSize
        height: rows * gridItemSize
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Rectangle {
            id: grid
            width: ( rows - 3 ) * gridItemSize
            height: rows * gridItemSize
            border.color: borderColor
            border.width: outsideBorder
            color: "transparent"
        }

        Item {
            anchors.right: parent.right
            width: parent.width - grid.width - ( gridItemSize / 2 )
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Item {
                width: gridItemSize * 3
                height: gridItemSize * 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    source: "/images/up.png"
                    width: buttonSize
                    height: buttonSize
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            goUp();
                        }
                    }
                }
                Image {
                    source: "/images/down.png"
                    width: buttonSize
                    height: buttonSize
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            goDown();
                        }
                    }
                }
                Image {
                    source: "/images/left.png"
                    width: buttonSize
                    height: buttonSize
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            goLeft();
                        }
                    }
                }
                Image {
                    source: "/images/right.png"
                    width: buttonSize
                    height: buttonSize
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            goRight();
                        }
                    }
                }

            }
        }

        Image {
            source: "/images/person.png"
            width: buttonSize
            height: buttonSize
            x: tokenX * gridItemSize + 2 * insideBorder
            y: tokenY * gridItemSize + 2 * insideBorder
        }

        Component.onCompleted: {
            tokenX = Math.floor(Math.random() * ( rows - 3 ) );
            tokenY = Math.floor(Math.random() * rows);

            //tokenX = 0;
            //tokenY = 0;

            boxes = [];
            for ( var x = 0; x < rows - 3; x++) {
                boxes[x]=[]
                for ( var y = 0; y < rows; y++ ) {
                    console.log("Creating ["+x+","+y+"] at ["+(x * gridItemSize)+","+(y * gridItemSize)+"]");
                    var obj = boxFactory.createObject(grid);
                    obj.x = x * gridItemSize;
                    obj.y = y * gridItemSize;
                    boxes[x][y]=obj;
                }
            }
        }
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
                tokenX = Math.floor(Math.random() * ( rows - 3 ) );
                tokenY = Math.floor(Math.random() * rows);
            }
        }
    }

}
