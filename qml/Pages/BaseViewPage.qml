import QtQuick 2.4
import QuickFlux 1.0
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../Component/MaterialMod"
import "../UI"
import "../QuickFlux/Actions"

Page {
    id: viewPage

    default property alias data: content.data

    actions: [
        Action {
            iconName: "action/search"
            name: qsTr("Search")
            onTriggered: {
//                musicLibraryManager.scanLocalMusic();
//                AppActions.selectMusicScannerDirs();
            }
        },
        Action {
            iconName: "action/settings"
            name: qsTr("Settings")
        }
    ]

    backAction: Action {
        iconName: "navigation/menu"
        visible: true
        onTriggered: {
            sidebar.expanded = !sidebar.expanded
        }
    }

    QtObject {
        id: inner
        property var sidebarLocalTitles: [
            qsTr("Album"),
            qsTr("Artist"),
            qsTr("Genres"),
            qsTr("All")
//            qsTr("Recent"),
//            qsTr("PlayList")
        ]
        property var sidebarLocalIconNames: [
            "av/album",
            "social/person",
            "av/web",
            "av/queue_music"
//            "av/queue",
//            "av/playlist_play"
        ]
    }

    Sidebar {
        id: sidebar
        Column {
            id: column
            width: parent.width
            ListItem.Subheader {
                text: qsTr("Local Music")
            }
            Repeater {
                id: musicRepeater
                property int selectedSection: 0
                model: inner.sidebarLocalTitles.length //size of sectionTitles
                delegate: ListItem.Standard {
                    width: parent.width
                    text: inner.sidebarLocalTitles[index]
                    selected: musicRepeater.selectedSection == index
                    iconName: inner.sidebarLocalIconNames[index]
                    onClicked: {
                        musicRepeater.selectedSection = index
                    }
                }
            }
            ListItem.Divider {}
            ListItem.SectionHeader {
                text: qsTr("Addon")
            }
            ListItem.Divider {}
            ListItem.SectionHeader {
                id: recentHeader
                text: qsTr("Recent")
            }
            Repeater {
                id: musicRepeater2
                property int selectedSection: 0
                model: recentHeader.expanded ? inner.sidebarLocalTitles.length : 0//size of sectionTitles
                delegate: ListItem.Standard {
                    width: parent.width
                    text: inner.sidebarLocalTitles[index]
                    selected: musicRepeater2.selectedSection == index
                    iconName: inner.sidebarLocalIconNames[index]
                    onClicked: {
                        musicRepeater2.selectedSection = index
                    }
                }
            }
            ListItem.Divider {}
            ListItem.Subheader {
                text: qsTr("Playlist")
            }
        }
    }
    Item {
        id: content
        anchors.left: sidebar.left
        anchors.right: parent.right
        height: parent.height
    }

    Button {
        anchors.centerIn: parent
        elevation: 1
        text: qsTr("Press to add music folder")
        visible: musicLibraryManager.empty();
        enabled: musicLibraryManager.empty()
        onClicked: {
            AppActions.selectMusicScannerDirs();
        }
        Component.onCompleted:  {
            console.log("==== musicLibraryManager.empty(); "+musicLibraryManager.empty())
        }
    }





}
