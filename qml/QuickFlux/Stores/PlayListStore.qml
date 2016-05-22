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


    property alias playListDelegate: listDelegate
    property alias playLists: listDelegate.availablePlayList
//    property var musicList
    property string openedPlaylistName: ""
    property var tracksInOpenedList: []
    onTracksInOpenedListChanged: {
        console.log("==== onTracksInOpenedListChanged "+tracksInOpenedList.length);
    }

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
            var override = message.override;
//            console.log("=== name "+name+" list "+list+ " override "+override);
            listDelegate.createPlaylist(name, list, override);
        }
    }
    Filter {
        type: ActionTypes.playPlst
        onDispatched: {
            var name = message.name;
            listDelegate.addToPlayQueue(name);
        }
    }
    Filter {
        type: ActionTypes.showTracksInPlst
        onDispatched:  {
            var name = message.name;
            openedPlaylistName = name;
            tracksInOpenedList = listDelegate.openPlaylist(name);
        }
    }

}
