pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

AppListener {
    id: playListStore

//
    property var queueModel: queueDelegate
    property int playQueueCount: queueDelegate.count
    property alias playingIdx: queueDelegate.playingIdx
    onPlayingIdxChanged: {
        console.log(">>>>>>>>>>>>>>> playListStore currentIndex "+playingIdx)
    }


    property var playLists: listDelegate.availablePlayList

    PlayListDelegate {
        id: listDelegate
    }

    PlayQueueDelegate {
        id: queueDelegate
    }


}
