import QtQuick 2.7

Rectangle {
    id: rectangle1
    anchors.fill: parent

    property int squareSize: Math.min(parent.height,parent.width)
    property int buttonSize: squareSize / 16

    color: "#000000"

    function randomLetter() {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var rnum = Math.floor(Math.random() * chars.length);
        var ch = chars.substring(rnum,rnum+1);
        console.log("Choosing letter '"+ch+"', number "+rnum);
        return ch;
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

            width: parent.width
            height: parent.height

            onPaint: {
                var context = getContext("2d");

                for (var i = 0; i < strokes.length; i++) {
                    var stroke = strokes[ i ];
                    if ( stroke.points.length > 1 ) {
                        // Draw a line
                        context.beginPath();
                        context.lineWidth = 2;
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

        MultiPointTouchArea {
            width: parent.width
            height: parent.height

            onPressed: {
                for (var i = 0; i < touchPoints.length; i++ ) {
                    var tp = touchPoints[ i ];
                    var path = { 'color': "#FF00FF", points: [ {'x':tp.x,'y':tp.y} ] };
                    canvas.strokes.push( path );
                    canvas.strokeMap[tp.pointId] = path;
                    console.log(tp.pointId + ": Started at ("+tp.x + ',' + tp.y+')');
                }

            }

            onUpdated: {
                for (var i = 0; i < touchPoints.length; i++ ) {
                    var tp = touchPoints[ i ];
                    canvas.strokeMap[tp.pointId].points.push({'x':tp.x,'y':tp.y});
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
            onClicked: {
                console.log( "Clearing drawing" );
                canvas.strokes = [];
                canvas.strokeMap = {};
                canvas.getContext("2d").clearRect ( 0,0 , canvas.width, canvas.height );
                canvas.requestPaint();
            }
        }
    }

    Image {
        source: "random.png"
        width: buttonSize
        height: buttonSize
        anchors.bottom: parent.bottom
        anchors.right: restartButton.left

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textView.text = randomLetter();
            }
        }
    }

}
