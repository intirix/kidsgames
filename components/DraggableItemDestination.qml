import QtQuick 2.7

Rectangle {
    id: me
    property var area: null
    color: "transparent"

    signal itemReleased(var item)

    function getX() {
        var ret = x;

        var obj = me;
        while (obj!=null && obj.parent!=area) {
            obj = obj.parent;
            if (obj!=null) {
                ret += obj.x;
            }
        }

        return ret;
    }

    function getY() {
        var ret = y;

        var obj = me;
        while (obj!=null && obj.parent!=area) {
            obj = obj.parent;
            if (obj!=null) {
                ret += obj.y;
            }
        }

        return ret;
    }

    Component.onCompleted: {
        // if the item was declared with an area to belong to,
        // add the item to the area
        if (area!==null) {
            area.addDestination(me);
        }
    }

}
