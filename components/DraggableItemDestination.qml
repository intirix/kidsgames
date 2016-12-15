import QtQuick 2.7

Rectangle {
    id: me
    property var area: null
    color: "transparent"

    signal itemReleased(var item)

    Component.onCompleted: {
        // if the item was declared with an area to belong to,
        // add the item to the area
        if (area!==null) {
            area.addDestination(me);
        }
    }

}
