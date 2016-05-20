pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"
import "../Adapters"

AppListener {
    id: playListStore

//
    property var queueModel: queueDelegate
    property int playQueueCount: queueDelegate.count
    property alias playingIdx: queueDelegate.playingIdx
    onPlayingIdxChanged: {
        console.log(">>>>>>>>>>>>>>> playListStore currentIndex "+playingIdx)
    }


    property alias playLists: listDelegate.availablePlayList
    property var musicList

    PlayListDelegate {
        id: listDelegate
        Component.onCompleted: {
            console.log("===== playListStore playLists "+listDelegate.availablePlayList)
        }
    }

    PlayQueueDelegate {
        id: queueDelegate
    }

    Filter {
        type: ActionTypes.savePlst
        onDispatched: {
            var name = message.name;
            var list = message.value;
//            console.log("=== name "+name+" list "+list);
            listDelegate.createPlaylist(name, list);
        }
    }
    Filter {
        type: ActionTypes.playPlst
        onDispatched: {
            var name = message.name;
            listDelegate.addToPlayQueue(name);
        }
    }

}
