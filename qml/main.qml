import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "Component"
import "Component/MaterialMod"
import "UI"

RootWindow {
    visible: true
    width: Units.dp(1280)
    height: Units.dp(800)
    title: qsTr("Phoenix Player")
//    flags: Qt.FramelessWindowHint

    id: demo

    theme {
        primaryColor: Palette.colors["blue"]["500"]
        primaryDarkColor: Palette.colors["blue"]["700"]
        accentColor: Palette.colors["red"]["A200"]
        tabHighlightColor: "white"
    }

    leftSideBar: MainVerticalNavigation {
        width: Units.dp(64)
    }

    bottomBar: PlayControlBar {
//        color: "#26d93e"
        anchors.fill: parent
    }

    LocalMusicSacnner {
        id: localMusicSacnner
    }

    initialPage: Page {
        id: page
        title: "Component Demo"

        actions: [
            Action {
                iconName: "action/search"
                name: qsTr("Search")
                onTriggered: {
                    musicLibraryManager.scanLocalMusic();
                }
            },

            Action {
                iconName: "action/settings"
                name: qsTr("Settings")
            }
        ]

        tabs: [
            {
                text: qsTr("PlayList")
            },
            {
                text: qsTr("Recent")
            },
            {
                text: qsTr("Album")
            },
            {
                text: qsTr("Artist")
            },
            {
                text: qsTr("All")
            },
            {
                text: qsTr("Genres")
            }
        ]

//        NavigationSideBar {
//            id: sidebar
//            width: units.dp(200)
//        }

//        Item {
//            anchors {
//                left: sidebar.right
//                right: parent.right
//                top: parent.top
//                bottom: playContrlBar.top
//            }
//            TabView {
//                id: tabView
//                anchors.fill: parent
//                clip: true
//                currentIndex: page.selectedTab
//                model: tabs
//            }
//            VisualItemModel {
//                id: tabs
//                property int index: tabView.currentIndex
//                onIndexChanged: {
//                    console.log("==== tabs index changed to " + index);
//                    if (index == 4) { //match  tabs array
//                        viewLoader.source = "qrc:/UI/TrackAllView.qml"
//                    }
//                }
//                Loader {
//                    id: viewLoader
//                    width: tabView.width
//                    height: tabView.height
//                }
//            }
//        }
//        Item {
//            id: playContrlBar
//            anchors {
//                left: sidebar.right
//                right: parent.right
//                bottom: parent.bottom
//            }
//            //follow the cover height in MySideBar
//            height: units.dp(80)
//            PlayControlSlider {
//                id: controlSlider
//                anchors.left: parent.left
//                anchors.right: parent.right
//                anchors.top: parent.top
//                anchors.bottom: parent.bottom
//            }
//        }
    }
}
