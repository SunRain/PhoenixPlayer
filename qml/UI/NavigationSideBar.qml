import QtQuick 2.2
import Material 0.1

import "../Component"

MySideBar {
    id: navigationSideBar

    property real coverSize

    signal topItemClicked
    signal bottomItemClicked

//    topItem: Component {
//        Image {
//            id: logo
//            source: "qrc:/icon_dummy.png"
//            width: navigationSideBar.width / 4
//            height: width
//            Ink {
//                anchors.fill: parent
//                onClicked: {topItemClicked();}
//            }
//        }
//    }

    bottomItem: Component {
        /*CoverImage*/Rectangle {
            id: cover
            width: navigationSideBar.width / 2
            height: width
            color: "#c802e2"
            //            onClicked: {bottomItemClicked();}
        }
    }

    Column {
        width: parent.width - units.dp(20)
        x: units.dp(10)
        spacing: units.dp(5)

        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon1")
        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon2")
        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon3")

        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon4")

        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon5")

        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon6")

        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon7")

        }
        IconTextButton {
            iconSource: "qrc:/icon_dummy.png"
            iconSize: units.dp(48)
            text: qsTr("icon8")

        }
    }
}

