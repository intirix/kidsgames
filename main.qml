import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    visibility: "FullScreen"
    title: qsTr("Hello World")

    Trace {
        anchors.fill: parent
    }
}
