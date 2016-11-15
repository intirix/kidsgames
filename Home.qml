import QtQuick 2.0

Rectangle {
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4
    property int buttonWidth: buttonSize * 11 / 10

    Component {
        id: gridDelegate
        Item {
            width: buttonWidth
            height: buttonSize
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

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stack.push(Qt.resolvedUrl(appUrl));
                        }
                    }

                }
            }
        }
    }

    GridView {
        width: parent.width
        height: parent.height

        cellHeight: buttonSize
        cellWidth: buttonWidth

        model: AppModel {}
        delegate: gridDelegate
    }

}
