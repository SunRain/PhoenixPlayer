import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

import "Component"
import "UI"

ApplicationWindow {
    visible: true
    width: 960
    height: 540
    title: qsTr("Phoenix Player")

    id: demo

    theme {
        primaryColor: Palette.colors["blue"]["500"]
        primaryDarkColor: Palette.colors["blue"]["700"]
        accentColor: Palette.colors["teal"]["500"]
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

        NavigationSideBar {
            id: sidebar
        }

        Item {
            anchors {
                left: sidebar.right
                right: parent.right
                top: parent.top
                bottom: playContrlBar.top
            }
            TabView {
                id: tabView
                anchors.fill: parent
                clip: true
                currentIndex: page.selectedTab
                model: tabs
            }
            VisualItemModel {
                id: tabs
                property int index: tabView.currentIndex
                onIndexChanged: {
                    console.log("==== tabs index changed to " + index);
                    if (index == 4) { //match  tabs array
                        viewLoader.source = "qrc:/UI/TrackAllView.qml"
                    }
                }
                Loader {
                    id: viewLoader
                    width: tabView.width
                    height: tabView.height
                }
            }
        }
        Rectangle {
            id: playContrlBar
            anchors {
                left: sidebar.right
                right: parent.right
                bottom: parent.bottom
            }
            //follow the cover height in MySideBar
            height: units.dp(125)
            color: "#e02a1a"
        }
    }
}
