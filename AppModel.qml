import QtQuick 2.0

ListModel {

    ListElement {
        appName: "Trace Letters";
        appIcon: "/images/pen-write.png";
        appUrl: "qrc:/trace/Trace.qml";
        appKey: "traceLetters";
        soundTip: ":/trace/howto-trace.ogg";
    }
    ListElement {
        appName: "Draw"
        appIcon: "/images/paint.png"
        appUrl: "qrc:/draw/DrawPage.qml"
        appKey: "draw";
        soundTip: ":/draw/howto.ogg";
    }
    ListElement {
        appName: "Sight Words"
        appIcon: "/reading/eye.png"
        appUrl: "qrc:/reading/SightWords.qml"
        appKey: "sightWords";
        soundTip: ":/reading/howto-sight-words.ogg";
    }
    ListElement {
        appName: "Similar Words"
        appIcon: "/images/message.png"
        appUrl: "qrc:/reading/SimilarWords.qml"
        appKey: "similarWords";
        soundTip: ":/reading/howto-similar.ogg";
    }
    ListElement {
        appName: "Shapes"
        appIcon: "/shapes/multiply-icon.png"
        appUrl: "qrc:/shapes/Shapes.qml"
        appKey: "shapes";
        soundTip: ":/shapes/howto.ogg";
    }
    ListElement {
        appName: "Colors"
        appIcon: "/images/colors.png"
        appUrl: "qrc:/colorSoundBoard/ColorSoundBoardPage.qml"
        appKey: "colors";
        soundTip: ":/colorSoundBoard/howto.ogg";
    }
    ListElement {
        appName: "Sort Animals"
        appIcon: "/sortAnimals/icon.png"
        appUrl: "qrc:/sortAnimals/SortAnimalsPage.qml"
        appKey: "sortAnimals";
        soundTip: ":/sortAnimals/howto.ogg";
    }
    ListElement {
        appName: "Christmas Tree"
        appIcon: "/christmasTree/icon.png"
        appUrl: "qrc:/christmasTree/ChristmasTreePage.qml"
        appKey: "christmasTree";
        soundTip: ":/christmasTree/howto.ogg";
    }
    ListElement {
        appName: "Match Balls"
        appIcon: "/matchBallNet/basketball.svg"
        appUrl: "qrc:/matchBallNet/MatchBallGoals.qml"
        appKey: "matchBalls";
        soundTip: ":/matchBallNet/howto.ogg";
    }
    ListElement {
        appName: "Ruler"
        appIcon: "/ruler/icon.png"
        appUrl: "qrc:/ruler/Ruler.qml"
        appKey: "ruler";
        soundTip: ":/ruler/howto.ogg";
    }
    ListElement {
        appName: "Counting"
        appIcon: "/counting/icon.png"
        appUrl: "qrc:/counting/SimpleCounting.qml"
        appKey: "counting";
        soundTip: ":/counting/howto-counting.ogg";
    }
    ListElement {
        appName: "Add"
        appIcon: "/images/add.png"
        appUrl: "qrc:/counting/Add.qml"
        appKey: "add";
        soundTip: ":/counting/howto-add.ogg";
    }
    ListElement {
        appName: "Directions"
        appIcon: "/images/up.png"
        appUrl: "qrc:/arrows/Directions.qml"
        appKey: "directions";
        soundTip: ":/arrows/howto.ogg";
    }
}
