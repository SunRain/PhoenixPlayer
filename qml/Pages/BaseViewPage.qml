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
import "../"

Page {
    id: viewPage

    property bool showLibraryPathSelector: false
    default property alias data: content.data
    readonly property real contentWidth: content.width

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
    }

    Snackbar {
        id: snackbar
        duration: 1000
        property string snackbarText: PlayCtrlBarInfoStore.playModeText
        onSnackbarTextChanged: {
            snackbar.open(snackbarText)
        }
    }






}
