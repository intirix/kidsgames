import QtQuick 2.7

MultiPointTouchArea {
    anchors.fill: parent

    property var tracked: ({})
    property var items: []

    function addItem(item) {
        items.push(item);
    }

    onPressed: {
        for (var i = 0; i < touchPoints.length; i++ ) {
            var tp = touchPoints[ i ];
            console.log(tp.pointId + ": Started at ("+tp.x + ',' + tp.y+')');

            for (var j = 0; j < items.length; j++ ) {
                var sprite = items[j];
                var coords = mapFromItem(sprite,0, 0);
                console.log(coords.x+"x"+coords.y);

                if (tp.x>=coords.x&&tp.y>=coords.y&&tp.x<=(coords.x+sprite.size)&&tp.y<=(coords.y+sprite.size)) {
                    console.log("Inside the box");
                    var canvasX = parseInt(tp.x - coords.x);
                    var canvasY = parseInt(tp.y - coords.y);
                    console.log("item "+canvasX+"x"+canvasY);
                    if (sprite.isHit(canvasX, canvasY)) {
                        console.log("HIT");

                        var obj = sprite.getReference();
                        tracked[tp.pointId] = {
                            sprite: obj,
                            offsetX: canvasX,
                            offsetY: canvasY
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
                obj.sprite.x = tp.x - obj.offsetX;
                obj.sprite.y = tp.y - obj.offsetY;
            }
        }
    }
}
