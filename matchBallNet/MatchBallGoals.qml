import QtQuick 2.7
import QtMultimedia 5.7
import "qrc:/components"
import KidGames 1.0

Rectangle {
    id: me
    color: "#FFFFFF"

    property color zoneColor: "#CCCCCC"
    property int zoneWidth: parent.width / 4
    property int zoneHeight: parent.height / 2
    property int squareSize: Math.min(zoneHeight,zoneWidth) * 7 / 10
    property int ballSize: squareSize/3


    property int startMinX: 0
    property int startMinY: backButton.height
    property int startMaxX: parent.width
    property int startMaxY: parent.height / 2

    property var items: []

    SoundClip {
        id: howToClip;
        qrcPath: ":/matchBallNet/howto.ogg";
    }

    DraggableItemArea {
        id: area
    }

    Rectangle {
        id: basketballZone
        width: zoneWidth
        height: zoneHeight
        anchors.bottom: me.bottom
        anchors.left: me.left

        DraggableItemDestination {
            id: basketballDest
            color: zoneColor
            area: area
            width: squareSize
            height: squareSize
            anchors.centerIn: parent

            Image {
                source: "/matchBallNet/basketball-net.svg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent

            }

            onItemReleased: {
                handleDrop(item,"BASKETBALL");
            }

        }
    }
    Rectangle {
        id: soccerZone
        width: zoneWidth
        height: zoneHeight
        anchors.bottom: me.bottom
        anchors.left: basketballZone.right

        DraggableItemDestination {
            id: soccerDest
            color: zoneColor
            area: area
            width: squareSize
            height: squareSize
            anchors.centerIn: parent

            Image {
                source: "/matchBallNet/soccer-net.svg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent

            }

            onItemReleased: {
                handleDrop(item,"SOCCER");
            }

        }
    }
    Rectangle {
        id: footballZone
        width: zoneWidth
        height: zoneHeight
        anchors.bottom: me.bottom
        anchors.left: soccerZone.right

        DraggableItemDestination {
            id: footballDest
            color: zoneColor
            area: area
            width: squareSize
            height: squareSize
            anchors.centerIn: parent

            Image {
                source: "/matchBallNet/football-goal.svg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent

            }
            onItemReleased: {
                handleDrop(item,"FOOTBALL");
            }

        }
    }
    Rectangle {
        id: baseballZone
        width: zoneWidth
        height: zoneHeight
        anchors.bottom: me.bottom
        anchors.left: footballZone.right

        DraggableItemDestination {
            id: baseballDest
            color: zoneColor
            area: area
            width: squareSize
            height: squareSize
            anchors.centerIn: parent

            Image {
                source: "/matchBallNet/baseball-diamond.svg"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent

            }

            onItemReleased: {
                handleDrop(item,"BASEBALL");
            }

        }
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

    function handleDrop(item, dest) {
        console.log("Tried to drop "+item.metadata+" onto "+dest);
        if (item.metadata === dest) {
            item.visible = false;
        } else {
            item.visible = true;
        }
    }

    function restart() {
        for (var i = 0; i < items.length; i++) {
            items[ i ].moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
            items[ i ].visible = true;
        }
    }

    function createBall(imgSrc,dest) {
        var component = Qt.createComponent("qrc:/components/DraggableItem.qml");
        var obj = component.createObject(me, {"size": ballSize, "area": area, "source": imgSrc, "cloneItem": false, "metadata": dest});
        obj.moveToRandomPosition(startMinX, startMinY, startMaxX, startMaxY);
        items.push(obj);

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
        for (var i = 0; i < 2; i++) {
            createBall("baseball.svg","BASEBALL");
            createBall("soccerball.svg","SOCCER");
            createBall("basketball.svg","BASKETBALL");
            createBall("football.svg","FOOTBALL");
        }
        howToClip.play();
    }
}
