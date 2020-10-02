import QtQuick 2.7
import QtQuick.Controls 1.4
import "qrc:/components"

Rectangle {
    id: page
    color: "white"

    property int squareSize: Math.min(parent.height,parent.width)

    ListModel {
        id: model
    }

    ListView {
        id: list
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: model
        delegate: Text {
            text: label+"\n";
            color: "black"
            textFormat: Text.MarkdownText;
            onLinkActivated: Qt.openUrlExternally(link);
            wrapMode: Text.Wrap;
            width: page.width;
        }
    }

    Component.onCompleted: {
        model.clear();
        var credits = privacy_policy_md;
        var items = credits.split("\n\n");
        for (var i = 0; i < items.length; i++ ) {
            console.log(items[i]);
            //model.append({"label":items[i]});
        }
        model.append({"label":privacy_policy_md});
    }

    BackButton {
        id: backButton
        stackRef: stack
    }

}
