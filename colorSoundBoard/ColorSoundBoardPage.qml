import QtQuick 2.7
import QtMultimedia 5.7
import "qrc:/components"
import KidGames 1.0

Rectangle {
    id: page
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/3
    property int buttonWidth: buttonSize * 11 / 10

    property var lastSelected: null

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

                    QrcCache {
                        id: soundCache
                        source: speechAudio
                    }

                    Audio {
                        id: speechClip
                        source: "file:"+soundCache.path
                    }


                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            // Just in case the last border wasn't removed
                            if (lastSelected) {
                                lastSelected.border.width = 0
                            }

                            page.color = selectColor
                            gridItemCircle.border.width = 10

                            // multi-touch screens could cause onReleased to be skipped
                            // this means the border doesn't get removed
                            // save this item for later so we can remove the border
                            lastSelected = gridItemCircle

                            speechClip.play();
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
