import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import "qrc:/components"


Rectangle {
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4
    property int buttonHeight: buttonSize * 12 / 10
    property int buttonWidth: buttonSize * 11 / 10

    Storage {
        id: storage
    }

    BackButton {
        id: backButton
        stackRef: stack
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
                        ColorOverlay {
                            anchors.fill: icon
                            source: icon
                            color: (storage.getItem("pages."+appKey+".enabled","true")==="true"?"#00000000":"#80800000");
                        }
                    }

                    Text {
                        id: label
                        text: appName

                        color: (storage.getItem("pages."+appKey+".enabled","true")==="true"?themeForegroundColor:"#808000");
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        font {
                            pixelSize: buttonSize * 3 / 20
                        }

                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (storage.getItem("pages."+appKey+".enabled","true")==="true") {
                                storage.setItem("pages."+appKey+".enabled","false");
                            } else {
                                storage.setItem("pages."+appKey+".enabled","true");
                            }
                            refreshAppList();
                            stack.get(0).refreshAppList();
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
        anchors.top: backButton.bottom;
        anchors.bottom: parent.bottom;

        cellHeight: buttonHeight
        cellWidth: buttonWidth

        model: realModel;
        delegate: gridDelegate
    }



    function refreshAppList() {
        realModel.clear();
        for (var i=0; i<appList.count; i++) {
            var obj = appList.get(i);
            realModel.append(obj);
        }
    }

    Component.onCompleted: {
        refreshAppList();
    }

}
