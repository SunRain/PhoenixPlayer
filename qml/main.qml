import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "Component"
import "Component/MaterialMod"
import "UI"
import "Pages"

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

    initialPage: Component {
        LocalMusicPage {}
    }
}
