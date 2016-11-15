import QtQuick 2.7
import "qrc:/components"

Rectangle {
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4

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

                    width: buttonSize
                    height: buttonSize
                    color: themeBackgroundColor

                    Rectangle {
                        id: gridItemCircle
                        width: parent.width
                        height: parent.height
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

        cellHeight: buttonSize
        cellWidth: buttonSize

        model: ColorModel {}
        delegate: gridDelegate
    }
}
