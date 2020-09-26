import QtQuick 2.7
import "qrc:/components"

Rectangle {
    id: me
    color: "#FFFFFF"


    property int rulerMarks: 6
    property int rulerMarkWidth: me.width / 100

    SoundClip {
        id: howToClip;
        qrcPath: ":/ruler/howto.ogg";
        playOnLoad: true;
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

    Rectangle {
        height: 200;
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width / 10
        anchors.leftMargin: parent.width / 10
        anchors.rightMargin: parent.width / 10
        color: "#FFFF00";


        Rectangle {
            width: rulerMarkWidth
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width / rulerMarks
            color: "#000000"
            border.color: "#000000"
            border.width: 1
        }
        Rectangle {
            width: rulerMarkWidth
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 2 * ( parent.width / rulerMarks )
            color: "#000000"
            border.color: "#000000"
            border.width: 1
        }
        Rectangle {
            width: rulerMarkWidth
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 3 * ( parent.width / rulerMarks )
            color: "#000000"
            border.color: "#000000"
            border.width: 1
        }
        Rectangle {
            width: rulerMarkWidth
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 4 * ( parent.width / rulerMarks )
            color: "#000000"
            border.color: "#000000"
            border.width: 1
        }
        Rectangle {
            width: rulerMarkWidth
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 5 * ( parent.width / rulerMarks )
            color: "#000000"
            border.color: "#000000"
            border.width: 1
        }








        Rectangle {
            width: parent.width / rulerMarks
            height: parent.height;
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0 * ( parent.width / rulerMarks )
            color: "transparent"

            Text {
                text: qsTr("1")
                font.pixelSize: parent.height * 7 / 10
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: parent.width / rulerMarks
            height: parent.height;
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 1 * ( parent.width / rulerMarks )
            color: "transparent"

            Text {
                text: qsTr("2")
                font.pixelSize: parent.height * 7 / 10
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: parent.width / rulerMarks
            height: parent.height;
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 2 * ( parent.width / rulerMarks )
            color: "transparent"

            Text {
                text: qsTr("3")
                font.pixelSize: parent.height * 7 / 10
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: parent.width / rulerMarks
            height: parent.height;
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 3 * ( parent.width / rulerMarks )
            color: "transparent"

            Text {
                text: qsTr("4")
                font.pixelSize: parent.height * 7 / 10
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: parent.width / rulerMarks
            height: parent.height;
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 4 * ( parent.width / rulerMarks )
            color: "transparent"

            Text {
                text: qsTr("5")
                font.pixelSize: parent.height * 7 / 10
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: parent.width / rulerMarks
            height: parent.height;
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 5 * ( parent.width / rulerMarks )
            color: "transparent"

            Text {
                text: qsTr("6")
                font.pixelSize: parent.height * 7 / 10
                anchors.centerIn: parent
            }
        }








    }

}
