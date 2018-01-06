import QtQuick 2.7

MultiPointTouchArea {
    id: area
    anchors.fill: parent

    property var tracked: ({})
    property var items: []
    property var destList: []
    property var locationReference: area
    property real scale: 1
    property real speed: 1.0 / scale

    function addItem(item) {
        item.area = area;
        items.push(item);
    }

    function addDestination(dest) {
        destList.push(dest)
    }

    onPressed: {

        /*
        var root = parent
        while (root.parent !== undefined && root.parent !== null) {
            root = root.parent;
        }
        */

        if (locationReference!=null) {
            console.log("Reference is at "+locationReference.x+"x"+locationReference.y);
        }

        for (var i = 0; i < touchPoints.length; i++ ) {
            var tp = touchPoints[ i ];
            console.log(tp.pointId + ": Started at ("+tp.x + ',' + tp.y+')');

            var areaCoords = parent.mapFromItem(area,0, 0);
            console.log("area at "+areaCoords.x+"x"+areaCoords.y);

            for (var j = 0; j < items.length; j++ ) {
                var sprite = items[j];
                var coords = mapFromItem(sprite,0, 0);
                var targetCoords = mapFromItem(sprite.moveTarget, 0, 0);
                console.log("Item currently at "+coords.x+"x"+coords.y);

                var spriteSize = sprite.size * scale;

                if (sprite.visible&&sprite.draggable&&tp.x>=coords.x&&tp.y>=coords.y&&tp.x<=(coords.x+spriteSize)&&tp.y<=(coords.y+spriteSize)) {
                    console.log("Inside the box");
                    var canvasX = parseInt(tp.x - coords.x);
                    var canvasY = parseInt(tp.y - coords.y);
                    console.log("item "+canvasX+"x"+canvasY);
                    if (sprite.isHit(canvasX, canvasY)) {
                        var initX = sprite.moveTarget.x;
                        var initY = sprite.moveTarget.y;
                        if (locationReference!=null) {
                            initX = locationReference.x+locationReference.mapFromItem(sprite.moveTarget,0,0).x / scale;
                            initY = locationReference.y+locationReference.mapFromItem(sprite.moveTarget,0,0).y / scale;
                        }
                        console.log("sprite target location: "+sprite.moveTarget.x+"x"+sprite.moveTarget.y+", fromRef: "+initX+"x"+initY);
                        console.log("HIT, start at offset "+canvasX+"x"+canvasY+" location is "+initX+"x"+initY);

                        var obj = sprite.getReference();
                        tracked[tp.pointId] = {
                            sprite: obj,
                            target: obj.moveTarget,
                            offsetX: canvasX,
                            offsetY: canvasY,
                            dragStartX: tp.x,
                            dragStartY: tp.y,
                            initX: initX,
                            initY: initY
                        };

                        // if we cloned the item, we need to add it as a trackable item
                        if (sprite.cloneItem) {
                            addItem(obj);
                        }

                        return;
                    }
                }
            }
        }
    }

    onUpdated: {
        for (var i = 0; i < touchPoints.length; i++ ) {
            var tp = touchPoints[ i ];

            if (tracked[tp.pointId]!==undefined) {
                var obj = tracked[tp.pointId];

                // make sure what you are dragging is visible
                obj.sprite.visible = true;


                var draggedX = parseInt(speed*(tp.x - obj.dragStartX));
                var draggedY = parseInt(speed*(tp.y - obj.dragStartY));

                console.log("Moved by "+draggedX+"x"+draggedY);
                if (draggedX !== 0 && draggedY !== 0){
                    var oldX = obj.target.x;
                    var oldY = obj.target.y;
                    obj.target.x = obj.initX + draggedX;
                    obj.target.y = obj.initY + draggedY;
                    //obj.sprite.x = tp.x - obj.offsetX;
                    //obj.sprite.y = tp.y - obj.offsetY;

                    var movedX = obj.target.x - oldX;
                    var movedY = obj.target.y - oldY;

                    var errorX = parseInt((tp.x - obj.offsetX)-(obj.initX + draggedX));
                    var errorY = parseInt((tp.y - obj.offsetY)-(obj.initY + draggedY));
                    console.log("error="+errorX+"x"+errorY);
                    console.log("Target moved from "+oldX+"x"+oldY+" to "+obj.target.x+","+obj.target.y);

                    // make sure what you are dragging is visible
                    obj.sprite.visible = true;
                }

            }
        }
    }

    onReleased: {
        for (var i = 0; i < touchPoints.length; i++ ) {
            var tp = touchPoints[ i ];

            if (tracked[tp.pointId]!==undefined) {
                var obj = tracked[tp.pointId];
                console.log("Dropped point at "+obj.target.x+"x"+obj.target.y);

                area.objectReleased(obj);

                // iterate over all destinations to see if the release was in one
                for (var j = 0; j < destList.length; j++) {
                    var dest = destList[ j ];

                    // calculate the dest local coordinates of the release point
                    var destReleasePoint = Qt.point(tp.x - dest.getX(), tp.y - dest.getY());

                    // if the release was in the destination
                    if (dest.contains(destReleasePoint)) {
                        console.log("dest["+j+"] loc="+dest.getX()+"x"+dest.getY()+" point="+tp.x+"x"+tp.y);
                        dest.itemReleased(obj.sprite);
                    }
                }

                delete tracked[tp.pointId];
            }
        }
    }

    signal objectReleased(var obj)
}
