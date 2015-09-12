import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

import com.sunrain.phoenixplayer.qmlplugin 1.0


import "../Component"
import "../Component/MaterialMod"
import "../UI"

Page {
    id: settingsPage

    title: qsTr("Settings")

    Scrollbar {
        flickableItem: main
    }

    Flickable {
        id: main
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: Units.dp(5)


            ListItem.SectionHeader {
                id: header
                text: qsTr("Library settings")

                ThinDivider {
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    visible: header.expanded
                }
            }
            Flow {
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Units.dp(16)
                }

                visible: header.expanded
                spacing: Units.dp(10)
                Button {
                    text: qsTr("Refresh")
                    onClicked:  {
                        localMusicSacnner.scanLocalMusic();
                    }
                }

            }
        }
    }
}
