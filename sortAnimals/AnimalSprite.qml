import QtQuick 2.0

Rectangle {

    property var size: 200
    property url source: "qrc:/images/animals/whale.png"
//    width: size
//    height: size
    x: 10
    y: 20

    function isHit(x,y) {
        var data = canvas.getContext("2d").getImageData(x, y, 1, 1)
        return data.data[3]>0;
    }

    Image {
        id: refImage
        source: parent.source
        visible: false

        //Component.onCompleted: {
        //    canvas.requestPaint();
        //}
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
//            console.log(width+"x"+height);
//            console.log(refImage.width+"x"+refImage.height);
//            console.log(xScale+" x "+yScale);
        }

        onImageLoaded: {
            requestPaint();
        }
    }

}
