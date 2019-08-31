import QtQuick 2.7

Rectangle {
    id: me
    property var area: null
    color: "transparent"
    property bool associated: false;

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

    function associateWithArea() {
        // if the dest was declared with an area to belong to,
        // add the dest to the area
        if (area!==null && area!==undefined) {
            if (!associated) {
                associated = true;
                area.addDestination(me);
            }
        }
    }

    Component.onCompleted: {
        associateWithArea();
    }

    onAreaChanged: {
        associateWithArea();
    }

}
