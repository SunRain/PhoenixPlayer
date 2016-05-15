import QtQuick 2.4
import QuickFlux 1.0
import Material 0.3
import Material.Extras 0.1
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

BaseViewPage {
    id: localMusicViewPage

    showLibraryPathSelector: LocalMusicStore.model.count == 0

    Loader {
        id: viewLoader
        anchors.fill: parent
        source: LocalMusicStore.sourceUri
    }
}
