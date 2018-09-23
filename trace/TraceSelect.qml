import QtQuick 2.7

Rectangle {
    color: themeBackgroundColor

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize/4
    property string lettercase: "UPPER"

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
                        text: ( lettercase=="UPPER" ? character.toUpperCase() : character.toLowerCase() );
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
        visible: lettercase!=="NUMBER";
        width: parent.width
        height: parent.height

        cellHeight: buttonSize
        cellWidth: buttonSize

        model: TraceCapitolLetterModel {}
        delegate: gridDelegate
    }
    GridView {
        visible: lettercase==="NUMBER";
        width: parent.width
        height: parent.height

        cellHeight: buttonSize
        cellWidth: buttonSize

        model: TraceNumberModel {}
        delegate: gridDelegate
    }
}
