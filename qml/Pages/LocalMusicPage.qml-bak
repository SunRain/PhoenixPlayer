import QtQuick 2.2
import Material 0.2
import Material.ListItems 0.1 as ListItem
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../Component/MaterialMod"
import "../UI"

TabbedPage/*Page*/ {
    id: page
    title: qsTr("Local music")

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

    property var sectionTitles: [
        qsTr("Album"),
        qsTr("Artist"),
        qsTr("Genres"),
        qsTr("All"),
        qsTr("Recent"),
        qsTr("PlayList")
    ]
    property var sectionIconNames: [
        "av/album",
        "social/person",
        "av/web",
        "av/queue_music",
        "av/queue",
        "av/playlist_play"
    ]
    Sidebar {
        id: sideBar
        expanded: true
        Column {
            width: parent.width
            Repeater {
                id: sidebarRepeater
                property int selectedSection: 0
                model: 6 //size of sectionTitles
                delegate: ListItem.Standard/*Subtitled*/ {
                    width: parent.width
                    text: sectionTitles[index]
                    selected: sidebarRepeater.selectedSection == index
                    iconName: sectionIconNames[index]
                    onClicked: {
                        sidebarRepeater.selectedSection = index
                    }
                }
            }

        }
    }


    Repeater {
        model: 6 //size of sectionTitles

        delegate: Tab {
            id: tab
            clip: true
            title: sectionTitles[index]
//            property string selectedComponent: modelData[0]
//            property var section: modelData
//            sourceComponent: Item {
//                anchors.fill: parent
//                clip: true
//                Loader {
//                    anchors.fill: parent
//                    source: {
//                        if (index == 4)
//                            return "qrc:/UI/TrackAllView.qml";
//                    }
//                }
//            }
//            source: {
//                if (index == 2) {
//                    return "qrc:/UI/TrackGroupView.qml, {pageType: }";
//                }
//                if (index == 4)
//                    return "qrc:/UI/TrackAllView.qml";
//            }
            Component.onCompleted: {
                console.log("==== Tab onCompleted with index " + index);
                if (index == 2) {
                    var type = TrackGroupModel.TypeAlbum
                    tab.setSource("qrc:/UI/TrackGroupView.qml",
                                  {"pageType":type});
                }
                if (index == 3) {
                    type = TrackGroupModel.TypeArtist
                    tab.setSource("qrc:/UI/TrackGroupView.qml",
                                  {"pageType":type});
                }
                if (index == 4) {
//                    return "qrc:/UI/TrackAllView.qml";
                    tab.setSource("qrc:/UI/TrackAllView.qml");
                }
                if (index == 5) {
                    type = TrackGroupModel.TypeGenre
                    tab.setSource("qrc:/UI/TrackGroupView.qml",
                                  {"pageType":type});
                }
            }
        }
    }

}
