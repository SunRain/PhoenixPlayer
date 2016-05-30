import QtQuick 2.4
import Material 0.3

import "../"

Label {
    id: root
    clip: true
    property int maxHeight: Const.itemHeight

    property int __fullHeight: implicitHeight
    property bool __overflow: false
    property bool __collapsed: false

    onLinkActivated: {
        Qt.openUrlExternally(link);
    }
    function updateHeight() {
        if (__overflow) {
            if (__collapsed) {
                root.height = maxHeight;
            } else {
                root.height = __fullHeight;
            }
        }
    }

    Behavior on height {
        NumberAnimation { duration: 300 }
    }

    onHeightChanged: {
        if (!__overflow) {
            if (root.height > maxHeight) {
                __overflow = true;
                __collapsed = true;
                __fullHeight = root.height;
                updateHeight();
            }
        }
    }
    Icon {
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        size: 24 * Units.dp
        name: "navigation/expand_more"
        rotation: __collapsed ? 0 : 180
        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
        visible: __overflow
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            __collapsed = !__collapsed;
            updateHeight();
        }
    }
}
