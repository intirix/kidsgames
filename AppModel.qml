import QtQuick 2.0

ListModel {

    ListElement {
        appName: "Trace Letters"
        appIcon: "/images/pen-write.png"
        appUrl: "qrc:/trace/Trace.qml"
    }
    ListElement {
        appName: "Draw"
        appIcon: "/images/pen-draw.png"
        appUrl: "qrc:/draw/DrawPage.qml"
    }
    ListElement {
        appName: "Color Sound Board"
        appIcon: "/images/colors.png"
        appUrl: "qrc:/colorSoundBoard/ColorSoundBoardPage.qml"
    }
    ListElement {
        appName: "Sort Animals"
        appIcon: "/sortAnimals/icon.png"
        appUrl: "qrc:/sortAnimals/SortAnimalsPage.qml"
    }
    ListElement {
        appName: "Christmas Tree"
        appIcon: "/christmasTree/icon.png"
        appUrl: "qrc:/christmasTree/ChristmasTreePage.qml"
    }
}
