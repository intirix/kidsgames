import QtQuick 2.0

Rectangle {
    id: me

    property var size: 200
    property url source: "qrc:/images/animals/whale.png"
    property bool cloneItem: false
    property var cloneParent: parent
    property var area: null

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
        var data = canvas.getContext("2d").getImageData(x, y, 1, 1)
        return data.data[3]>0;
    }

    function getReference() {
        if (cloneItem) {
            var component = Qt.createComponent("DraggableItem.qml");
            return component.createObject(cloneParent, {"size": size, "source": source, "x": x, "y": y, "cloneItem": false});
        } else {
            return me
        }
    }

    Image {
        id: refImage
        source: parent.source
        visible: false
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
            ctx.drawImage(source,0,0, xScale, yScale);
        }

        onImageLoaded: {
            requestPaint();
        }
    }

}
