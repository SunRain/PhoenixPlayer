pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"

AppListener {
    property alias model: groupDelegate

    AudioGroupDelegate {
        id: groupDelegate
    }

//    Filter {

//    }
}
