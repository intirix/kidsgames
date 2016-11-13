import QtQuick 2.7

Rectangle {
    id: page
    objectName: "Trace"

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 12
    property int lineWidth: squareSize / 200

    color: "#000000"

    property color drawColor: "#FF00FF"

    function randomLetter() {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var rnum = Math.floor(Math.random() * chars.length);
        var ch = chars.substring(rnum,rnum+1);
        console.log("Choosing letter '"+ch+"', number "+rnum);
        return ch;
    }

    function setText(txt) {
        textView.text = txt;
    }

    function setDrawColor(c) {
        drawColor = c;
    }

    function clearLines() {
        console.log( "Clearing drawing" );
        canvas.strokes = [];
        canvas.strokeMap = {};
        canvas.getContext("2d").clearRect ( 0,0 , canvas.width, canvas.height );
        canvas.requestPaint();
    }

    Text {
        id: textView
        color: "#ffffff"
        text: "M"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            pixelSize: squareSize * 9 / 10
        }

        Component.onCompleted: {
            text = randomLetter();
        }
    }

    Rectangle {
        width: parent.width
        height: textView.height
        color: "transparent"


        Canvas {
            id: canvas
            property var strokes: []
            property var strokeMap: ({})

            property var strokeEvents: []

            width: parent.width
            height: parent.height

            onPaint: {
                //console.log("onPaint("+region+")");
                var context = getContext("2d");
                var i;

                // if there are stroke events to process
                // then just draw the stroke events
                if (strokeEvents.length>0) {
                    for (i = 0; i < strokeEvents.length; i++) {
                        var event = strokeEvents[ i ];
                        // Draw a line
                        context.beginPath();
                        context.lineWidth = lineWidth;
                        context.moveTo(event.x1, event.y1);
                        context.strokeStyle = drawColor;
                        context.lineTo(event.x2, event.y2);

                        console.log("Drawing line (width="+lineWidth+") ["+parseInt(event.x1)+","+parseInt(event.y1)+"] -> ["+parseInt(event.x2)+","+parseInt(event.y2)+"]")
                        context.stroke();
                    }
                    strokeEvents = [];
                } else {
                    // if there are no stroke events, then redraw everything

                    for (i = 0; i < strokes.length; i++) {
                        var stroke = strokes[ i ];
                        if ( stroke.points.length > 1 ) {
                            // Draw a line
                            context.beginPath();
                            context.lineWidth = lineWidth;
                            context.moveTo(stroke.points[0].x, stroke.points[0].y);
                            context.strokeStyle = stroke.color;
                            for (var j = 1; j < stroke.points.length; j++) {
                                context.lineTo(stroke.points[j].x, stroke.points[j].y);
                            }

                            context.stroke();
                        }
                    }
                }
            }

        }

        MultiPointTouchArea {
            width: parent.width
            height: parent.height

            onPressed: {
                for (var i = 0; i < touchPoints.length; i++ ) {
                    var tp = touchPoints[ i ];
                    var path = { 'color': drawColor, points: [ {'x':tp.x,'y':tp.y} ] };
                    canvas.strokes.push( path );
                    canvas.strokeMap[tp.pointId] = path;
                    console.log(tp.pointId + ": Started at ("+tp.x + ',' + tp.y+')');
                }

            }

            onUpdated: {
                for (var i = 0; i < touchPoints.length; i++ ) {
                    var tp = touchPoints[ i ];
                    var lastPoint = canvas.strokeMap[tp.pointId].points[ canvas.strokeMap[tp.pointId].points.length - 1 ];
                    canvas.strokeMap[tp.pointId].points.push({'x':tp.x,'y':tp.y});
                    canvas.strokeEvents.push({'x1':lastPoint.x,'y1':lastPoint.y,'x2':tp.x,'y2':tp.y});
                    //console.log(tp.pointId + ": Moved from ("+tp.previousX + ',' + tp.previousY+") to ("+tp.x + ',' + tp.y+')');
                }
                canvas.requestPaint();
            }

            onReleased: {
                for (var i = 0; i < touchPoints.length; i++ ) {
                    var tp = touchPoints[ i ];
                    console.log(tp.pointId + ": Finished at ("+tp.x + ',' + tp.y+')');
                }
            }


        }
    }

    Image {
        id: restartButton
        source: "restart.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: clearLines();
        }
    }

    Image {
        id: randomButton
        source: "random.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: restartButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                clearLines();
                textView.text = randomLetter();
            }
        }
    }

    Rectangle {
        id: selectButton
        width: buttonSize
        height: buttonSize

        anchors.bottom: parent.bottom
        anchors.right: randomButton.left
        color: page.color
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "A"
            color: textView.color
            font {
                pixelSize: buttonSize * 9 / 10
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("TraceSelect.qml"))
            }
        }
    }

    Image {
        id: colorButton
        source: "colors.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: selectButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push(Qt.resolvedUrl("ColorSelect.qml"))
            }
        }
    }


}
