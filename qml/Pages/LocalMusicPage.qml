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
            title: sectionTitles[index]
//            property string selectedComponent: modelData[0]
//            property var section: modelData
            sourceComponent: Item {
                anchors.fill: parent
                clip: true
                Loader {
                    anchors.fill: parent
                    source: {
                        if (index == 4)
                            return "qrc:/UI/TrackAllView.qml";
                    }
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
