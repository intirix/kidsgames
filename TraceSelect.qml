import QtQuick 2.7

Rectangle {
    anchors.fill: parent
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4

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

                    Text {
                        id: gridItemText
                        text: character;
                        color: themeForegroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font {
                            pixelSize: buttonSize * 8 / 10
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            try {
                                var traceItem = stack.find(function(item,index){
                                    return 'Trace'===item.objectName;
                                });
                                traceItem.setText(gridItemText.text);
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
        width: parent.width
        height: parent.height

        cellHeight: buttonSize
        cellWidth: buttonSize

        model: TraceCapitolLetterModel {}
        delegate: gridDelegate
    }
}
