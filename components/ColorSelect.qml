import QtQuick 2.7
import "qrc:/components"

Rectangle {
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4
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
                    color: themeBackgroundColor

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
                            try {
                                var traceItem = stack.find(function(item,index){
                                    return item.setDrawColor!==undefined;
                                });
                                traceItem.setDrawColor(gridItemCircle.color);
                                traceItem.clearLines();
                            } catch (e) {

                            }

                            stack.pop();
                        }
                    }

                }
            }
        }
    }

    GridView {
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        cellHeight: buttonWidth
        cellWidth: buttonWidth

        model: ColorModel {}
        delegate: gridDelegate
    }
}
