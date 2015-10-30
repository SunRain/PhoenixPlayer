import QtQuick 2.2
import Material 0.1
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../Component/MaterialMod"
import "../UI"

TabbedPage {
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
        qsTr("PlayList"),
        qsTr("Recent"),
        qsTr("Album"),
        qsTr("Artist"),
        qsTr("All"),
        qsTr("Genres"),
    ]
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

//    Tab {
//        id: tabView
//        anchors.fill: parent
//        clip: true
//        currentIndex: page.selectedTab
//        model: tabs
//    }
//    VisualItemModel {
//        id: tabs
//        property int index: tabView.currentIndex
//        onIndexChanged: {
//            console.log("==== tabs index changed to " + index);
//            if (index == 4) { //match  tabs array
//                viewLoader.source = "qrc:/UI/TrackAllView.qml"
//            }
//        }
//        Loader {
//            id: viewLoader
//            width: tabView.width
//            height: tabView.height
//        }
//    }

}
