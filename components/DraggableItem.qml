import QtQuick 2.0

Rectangle {
    id: me

    property var size: 200
    property url source: "qrc:/images/animals/whale.svg"
    property bool cloneItem: false
    property var cloneParent: parent
    property var area: null
    property var metadata: null
    property var moveTarget: me
    property bool draggable: true

    color: "transparent"
    width: size
    height: size

    Component.onCompleted: {
        // if the item was declared with an area to belong to,
        // add the item to the area
        if (area!==null) {
            area.addItem(me);
        }
    }

    function isHit(x,y) {
        console.log("isHit("+x+","+y+")");
        var data = canvas.getContext("2d").getImageData(x/area.scale, y/area.scale, 1, 1)
        return data.data[3]>0;
    }

    function getReference() {
        if (cloneItem) {
            var component = Qt.createComponent("DraggableItem.qml");
            var obj = component.createObject(cloneParent, {"size": size, "source": source, "x": x, "y": y, "cloneItem": false});

            // don't draw the clone until we drag it a bit
            // this prevents a weird visual pop when first creating the item
            // when the original is not absolutely positioned
            obj.visible = false;
            return obj;
        } else {
            return me
        }
    }

    function moveToRandomPosition(minX, minY, maxX, maxY) {
        if (minX===undefined) {
            minX = 0;
        }
        if (minY===undefined) {
            minY = 0;
        }
        if (maxX===undefined) {
            maxX = parent.width;
        }
        if (maxY===undefined) {
            maxY = parent.height;
        }

        var width = maxX - minY - size;
        var height = maxY - minY - size;
        var offsetX = Math.random() * width;
        var offsetY = Math.random() * height;
        me.x = parseInt(minX + offsetX);
        me.y = parseInt(minY + offsetY);
        console.log("Moving to random position between "+minX+"x"+minY+" and "+maxX+"x"+maxY+" (box "+width+"x"+height+") -> "+me.x+"x"+me.y);
    }

    Image {
        id: refImage
        source: parent.source
        visible: false
        onStatusChanged: {
            if (refImage.status==Image.Ready) {
                console.log(source+" is ready");
                canvas.loadImage(source);
                canvas.requestPaint();
            }
        }

    }

    Canvas {
        id: canvas
        width: size
        height: size

        property var xScale: (refImage.width>refImage.height)?(width):(width*refImage.width/refImage.height)
        property var yScale: (refImage.height>refImage.width)?(height):(height*refImage.height/refImage.width)

        Component.onCompleted: {
            loadImage(source);
        }

        onPaint: {
            var ctx = getContext("2d");
            if (refImage.status==Image.Ready) {
                var xScale = (refImage.width>refImage.height)?(width):(width*refImage.width/refImage.height);
                var yScale = (refImage.height>refImage.width)?(height):(height*refImage.height/refImage.width);
                console.log("Drawing "+source);
                ctx.clearRect(0,0,size,size);
                ctx.drawImage(refImage,0,0, xScale, yScale);
            } else {
                console.log("Skipping draw because "+source+" is not ready");
            }
        }

        onImageLoaded: {
            requestPaint();
        }
    }

}
