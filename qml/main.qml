import QtQuick 2.2
import QuickFlux 1.0
import Material 0.2
import Material.ListItems 0.1 as ListItem
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "Component"
import "Component/MaterialMod"
import "UI"
import "Pages"
import "QuickFlux/Actions"
import "QuickFlux/Scripts"

RootWindow {
    visible: true
    title: qsTr("Phoenix Player")
//    flags: Qt.FramelessWindowHint

    id: demo

    theme {
        primaryColor: Palette.colors["blue"]["500"]
        primaryDarkColor: Palette.colors["blue"]["700"]
        accentColor: Palette.colors["red"]["A200"]
        tabHighlightColor: "white"
    }

    initialPage: MusicCategoryViewPage{}//BaseViewPage{}//LocalMusicPage {}

    bottomBar: PlayControlBar {
    }

    ProgressCircle {
        id: progressCircle
        anchors.centerIn: parent
        z: 10
        indeterminate: false
        width: Math.min(parent.width/10, parent.height/10)
        height: width
        dashThickness: Units.dp(8)
    }

    PlayerController {
        id: playerController
    }

    LocalTrackScanner {
        id: scanner
    }

    AppScript {
        runWhen: ActionTypes.showProgress
        script: {
            progressCircle.opacity = 1;
            progressCircle.indeterminate = true
        }
    }
    AppScript {
        runWhen: ActionTypes.hideProgress
        script: {
            progressCircle.indeterminate = false
            progressCircle.opacity = 0
        }
    }

}
