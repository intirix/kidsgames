import QtQuick 2.0

Rectangle {
    id: me

    property url source: "qrc:/images/animals/whale.svg"
    property bool cloneItem: false
    property var cloneParent: parent
    property var area: null
    property var metadata: null
    property var moveTarget: me
    property bool draggable: true

    property int size: 200;
    property int itemWidth: size;
    property int itemHeight: size;

    property bool associated: false;

    width: itemWidth;
    height: itemHeight;

    color: "transparent"

    onItemHeightChanged: {
        console.log("DI height changed to "+itemHeight);
        canvas.requestPaint();
    }

    onItemWidthChanged: {
        console.log("DI width changed to "+itemWidth);
        canvas.requestPaint();
    }

    function associateWithArea() {
        // if the item was declared with an area to belong to,
        // add the item to the area
        if (area!==null && area !==undefined) {
            if (!associated) {
                area.addItem(me);
                associated = true;
                console.log("Associated item with area");
            }
        } else {
            console.log("area is null or undefined, skipping association");
        }
    }

    Component.onCompleted: {
        associateWithArea();
    }

    function isHit(x,y) {
        console.log("isHit("+x+","+y+")");
        var data = canvas.getContext("2d").getImageData(x/area.scale, y/area.scale, 1, 1)
        return data.data[3]>0;
    }

    function getReference() {
        if (cloneItem) {
            var component = Qt.createComponent("DraggableItem.qml");
            var obj = component.createObject(cloneParent, {"itemWidth": me.itemWidth, "itemHeight": me.itemHeight, "source": source, "x": x, "y": y, "cloneItem": false});

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

        var width = maxX - minX - me.itemWidth;
        var height = maxY - minY - me.itemHeight;
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
                console.log(source+" is ready, source is "+refImage.width+"x"+refImage.height);
                canvas.loadImage(source);
                canvas.requestPaint();
            }
        }

    }

    Canvas {
        id: canvas
        width: me.itemWidth;
        height: me.itemHeight;

        Component.onCompleted: {
            loadImage(source);
        }

        onPaint: {
            console.log("paint("+width+"x"+height+")");
            var ctx = getContext("2d");
            if (refImage.status==Image.Ready) {


                if (itemHeight==itemWidth) {
                    var xScale = (refImage.width>refImage.height)?(width):(width*refImage.width/refImage.height);
                    var yScale = (refImage.height>refImage.width)?(height):(height*refImage.height/refImage.width);
                    console.log("Drawing "+source+", square scale=["+xScale+","+yScale+"]");
                    ctx.clearRect(0,0,me.width,me.height);
                    ctx.drawImage(refImage,0,0, xScale, yScale);
                } else {
                    xScale = itemWidth / refImage.width;
                    yScale = itemHeight / refImage.height;
                    console.log("Drawing "+source+", rect scale=["+itemWidth+","+itemHeight+"]");
                    ctx.clearRect(0,0,me.width,me.height);
                    ctx.drawImage(refImage,0,0, itemWidth, itemHeight);
                }
            } else {
                console.log("Skipping draw because "+source+" is not ready");
            }
        }

        onImageLoaded: {
            requestPaint();
        }
    }

}
