import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    visibility: "FullScreen"
    title: qsTr("Hello World")

    Trace {
        width: 100
        height: 100
        anchors.fill: parent
    }
}
