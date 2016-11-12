import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    visibility: "FullScreen"
    title: qsTr("Hello World")

    property color themeBackgroundColor: "#000000"
    property color themeForegroundColor: "#FFFFFF"

    StackView {
        id: stack
        initialItem: view
        anchors.fill: parent

        Component {
            id: view

            Trace {}
        }
    }
}
