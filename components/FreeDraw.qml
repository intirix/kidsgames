import QtQuick 2.7
import QtQuick.Window 2.2

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    property int lineWidth: 2
    property color drawColor: "#FF00FF"

    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation || Screen.primaryOrientation === Qt.InvertedPortraitOrientation

    // seed the max distance with 5% of the screen width
    // this is a bit of a magic number that was based on experimentation
    property real maxDistance: parent.width / 20
    property var lastReleasePoint: null

    onIsPortraitChanged: {
        clearLines();
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

    Canvas {
        id: canvas
        property var strokes: []
        property var strokeMap: ({})

        property var strokeEvents: []

        renderStrategy: Canvas.Cooperative
        renderTarget: Canvas.FramebufferObject

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
            var path = {};
            for (var i = 0; i < touchPoints.length; i++ ) {
                var tp = touchPoints[ i ];

                var newPath = true;

                // on my laptop, the screen isn't as sensitive as my son would like
                // the capacative pens sometimes register a gap when drawing a line
                // this code is designed to try and resume from the last ended path
                // if it was just a gap from a capacative pen
                if (maxDistance>0&&lastReleasePoint!==null) {
                    var dx = tp.x - lastReleasePoint.x;
                    var dy = tp.y - lastReleasePoint.y;
                    var d = Math.sqrt(dx*dx+dy*dy);

                    if (d<maxDistance) {
                        newPath = false;
                        path = { 'color': drawColor, points: [ {'x':lastReleasePoint.x,'y':lastReleasePoint.y} ] };
                        canvas.strokes.push( path );
                        canvas.strokeMap[tp.pointId] = path;

                        canvas.strokeMap[tp.pointId].points.push({'x':tp.x,'y':tp.y});
                        canvas.strokeEvents.push({'x1':lastReleasePoint.x,'y1':lastReleasePoint.y,'x2':tp.x,'y2':tp.y});
                        console.log(tp.pointId + ": Resuming from ("+lastReleasePoint.x+','+lastReleasePoint.y+") at ("+tp.x + ',' + tp.y+') dist='+d+", maxDist="+maxDistance);

                    }
                }

                if (newPath) {
                    path = { 'color': drawColor, points: [ {'x':tp.x,'y':tp.y} ] };
                    canvas.strokes.push( path );
                    canvas.strokeMap[tp.pointId] = path;
                    console.log(tp.pointId + ": Started at ("+tp.x + ',' + tp.y+')');

                }


            }

        }

        onUpdated: {
            for (var i = 0; i < touchPoints.length; i++ ) {
                var tp = touchPoints[ i ];
                var lastPoint = canvas.strokeMap[tp.pointId].points[ canvas.strokeMap[tp.pointId].points.length - 1 ];

                var dx = tp.x - lastPoint.x;
                var dy = tp.y - lastPoint.y;
                var d = Math.sqrt(dx*dx+dy*dy);
                if (d>maxDistance) {
                    maxDistance = d;
                }

                canvas.strokeMap[tp.pointId].points.push({'x':tp.x,'y':tp.y});
                canvas.strokeEvents.push({'x1':lastPoint.x,'y1':lastPoint.y,'x2':tp.x,'y2':tp.y});
                //console.log(tp.pointId + ": Moved from ("+tp.previousX + ',' + tp.previousY+") to ("+tp.x + ',' + tp.y+')');
            }
            canvas.requestPaint();
        }

        onReleased: {
            for (var i = 0; i < touchPoints.length; i++ ) {
                var tp = touchPoints[ i ];
                lastReleasePoint = Qt.point(tp.x, tp.y);
                console.log(tp.pointId + ": Finished at ("+tp.x + ',' + tp.y+')');
            }
        }


    }
}
