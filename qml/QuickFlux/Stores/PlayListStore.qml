pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

AppListener {
    id: playListStore

    property var listModel: listDelegate
    property int playingIdx: listDelegate.playQueue.currentIndex
    onPlayingIdxChanged: {
        console.log(">>>>>>>>>>>>>>> playListStore currentIndex "+playingIdx)
    }

//    onCurrentIndexChanged: {
//        console.log(">>>>>>>>>>>>>>> playListStore currentIndex "+currentIndex)
//    }

    property int playQueueCount: listDelegate.count
//    property var playListNames: listDelegate.listMgr.existPlayLists


    PlayListDelegate {
        id: listDelegate
    }
}
