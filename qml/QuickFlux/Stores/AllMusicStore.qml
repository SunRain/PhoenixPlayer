pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0


AppListener {
    property alias model: allMusicDelegate

    AllMusicDelegate {
        id: allMusicDelegate
    }

}
