pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"

AppListener {
    id: infoStore

    property var playPauseIcon: inner.isPlaying ? "av/pause" :"av/play_arrow"
    property var title: null
    property var album: null
    property var artist: null

    QtObject {
        id: inner
        property bool isPlaying: Player.playBackendState == Common.PlayBackendPlaying
        property int playBackendState: Common.PlayBackendStopped
        onPlayBackendStateChanged: {
            if (playBackendState == Common.PlayBackendPlaying) {
                isPlaying = true;
            } else {
                isPlaying = false;
            }
        }
    }

    Connections {
        target: Player
        onPlayBackendStateChanged: { //state
            inner.playBackendState = state;
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarCover
        onDispatched: {
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarTitle
        onDispatched: {
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarAlbumName
        onDispatched: {
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarArtistName
        onDispatched: {
        }
    }

//    Filter {
//        type: ActionTypes.adaptSkipBackward
//        onDispatched: {
//            var uid = message.uid;
//            console.log("==== infoStore ActionTypes.adaptSkipBackward uid "+uid);
//        }
//    }

}
