import QtQuick 2.0
import QtQuick.Controls 1.4
import "qrc:/components"

Rectangle {
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4
    property int buttonHeight: buttonSize * 12 / 10
    property int buttonWidth: buttonSize * 11 / 10

    ExitButton {
        id: exitButton
        anchors.right: parent.right
    }

    InfoButton {
        id: infoButton
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Image {
        id: settingsButton
        source: "/images/settings.png"
        width: squareSize / 12
        height: squareSize / 12
        anchors.bottom: parent.bottom
        anchors.left: infoButton.right

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("qrc:/DisableApps.qml"));
            }
        }
    }

    Component {
        id: gridDelegate
        Item {
            width: buttonWidth
            height: buttonHeight
            Column {
                Rectangle {

                    width: buttonWidth
                    height: buttonSize + label.height
                    color: themeBackgroundColor

                    Rectangle {
                        id: gridItemSquare
                        width: buttonSize
                        height: buttonSize
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            id: icon
                            source: appIcon
                            width: parent.width
                            height: parent.height
                        }
                    }

                    Text {
                        id: label
                        text: appName

                        color: themeForegroundColor
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        font {
                            pixelSize: buttonSize * 3 / 20
                        }

                    }

                    SoundClip {
                        id: tipClip;
                        qrcPath: soundTip;
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stack.push(Qt.resolvedUrl(appUrl));
                        }
                        onPressAndHold: {
                            tipClip.play();
                        }
                    }

                }
            }
        }
    }

    AppModel {
        id: appList;
    }

    ListModel {
        id: realModel;
    }

    GridView {
        width: parent.width
        anchors.top: exitButton.bottom
        anchors.bottom: infoButton.top

        cellHeight: buttonHeight
        cellWidth: buttonWidth

        model: realModel;
        delegate: gridDelegate
    }

    Storage {
        id: storage
    }

    function refreshAppList() {
        realModel.clear();
        for (var i=0; i<appList.count; i++) {
            var obj = appList.get(i);
            var appKey = "pages."+obj.appKey+".enabled";

            if (storage.getItem(appKey,"true")==="true") {
                console.log(obj.appKey);
                realModel.append(obj);
            }
        }
    }

    Component.onCompleted: {
        refreshAppList();
    }
}
