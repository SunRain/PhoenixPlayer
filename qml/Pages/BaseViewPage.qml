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
import "../QuickFlux/Stores"

Page {
    id: viewPage

    property bool showLibraryPathSelector: false
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

    NavigationSideBar {
        id: sidebar
    }

    Item {
        id: content
        anchors.left: sidebar.right
        anchors.right: parent.right
        height: parent.height
//        ListView {
//            anchors.fill: parent
//            model: AudioGroupStore.model
//            Component.onCompleted: {
//                console.log("===== main onCompleted data "+ AudioGroupStore.model.get(0));
//                console.log("===== main onCompleted value "+ model.Values);
//            }
//            delegate: Label{
//                text: model.KEY_NAME
//                Component.onCompleted: {
//                    console.log("===== Label onCompleted data "+ model.KEY_LIST);
//                    console.log("===== Label onCompleted model "+ AudioGroupStore.model.get(index).KEY_LIST);
//                    console.log("===== Label onCompleted parse "
//                                + AppUtility.groupObjectToList(AudioGroupStore.model.get(index).KEY_LIST));

//                }

//            }
//        }
//        Item {
//            anchors.fill: parent
//            ColumnFlow {
//                id: grid
//                anchors.fill: parent
//                columns: 5
//                model: 20

//                delegate: Rectangle {
//                    id: item
//                    height: 100.0 * Math.random()
//                    color: Qt.rgba(Math.random(), Math.random(), Math.random(), Math.random())
//                    Text {text: index}
//                }
//            }
//        }

    }

    Button {
        anchors.centerIn: parent
        elevation: 1
        text: qsTr("Press to add music folder")
        visible: showLibraryPathSelector//musicLibraryManager.empty();
        enabled: showLibraryPathSelector//musicLibraryManager.empty()
        onClicked: {
            AppActions.selectMusicScannerDirs();
        }
//        Component.onCompleted:  {
////            console.log("==== musicLibraryManager.empty(); "+musicLibraryManager.empty())
//        }
    }





}
