import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: page
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/3
    property int buttonWidth: buttonSize * 11 / 10

    BackButton {
        id: backButton
        stackRef: stack
    }

    Component {
        id: gridDelegate
        Item {
            width: buttonSize
            height: buttonSize
            Column {
                Rectangle {

                    width: buttonWidth
                    height: buttonWidth
                    color: "transparent"

                    Rectangle {
                        id: gridItemCircle
                        width: buttonSize
                        height: buttonSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: width * 0.5
                        color: selectColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                        }

                        onPressed: {
                            page.color = selectColor
                            gridItemCircle.border.width = 10
                        }

                        onReleased: {
                            page.color = themeBackgroundColor
                            gridItemCircle.border.width = 0
                        }
                    }

                }
            }
        }
    }

    GridView {
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        // set the width to match the max number of cells wide
        width: Math.floor(page.parent.width / buttonWidth)*buttonWidth

        cellHeight: buttonWidth
        cellWidth: buttonWidth

        model: ColorSoundModel {}
        delegate: gridDelegate
    }
}
