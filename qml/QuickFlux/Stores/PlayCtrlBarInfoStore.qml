pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"
import "../Adapters"

AppListener {
    id: infoStore

    property var playPauseIcon: inner.isPlaying ? "av/pause" :"av/play_arrow"
    property var title: null
    property var album: null
    property var artist: null
    property var coverUri: null
    property int durationInSeconds: 0
    property int tickInSeconds: 0

    property string currentHash: null

    QtObject {
        id: inner
        property bool isPlaying: Player.playBackendState == Common.PlayBackendPlaying
        property int playBackendState: Common.PlayBackendStopped
        onPlayBackendStateChanged: { //state
//            console.log("===== infoStore onPlayBackendStateChanged "+state)
            //playBackendState
//            console.log("===== infoStore onPlayBackendStateChanged "+Player.playBackendState)
            if (Player.playBackendState == Common.PlayBackendPlaying) {
                isPlaying = true;
            } else {
                isPlaying = false;
            }
        }
    }
    AudioMetaObjectKeyName {
        id: metaKey
    }

    Connections {
        target: Player
        onPlayBackendStateChanged: { //state
            inner.playBackendState = state;
        }
        onTrackChanged: { //currentTrack
            var trackMeta = currentTrack[metaKey.KeyTrackMeta]
            durationInSeconds = trackMeta[metaKey.KeyDuration];
            currentHash = currentTrack[metaKey.KeyHash];
            PlayCtrAdapter.adaptCtrlBarAlbumName();
            PlayCtrAdapter.adaptCtrlBarArtistName();
            PlayCtrAdapter.adaptCtrlBarCover();
            PlayCtrAdapter.adaptCtrlBarTitle();
//            PlayCtrAdapter.adaptSkipBackward();
//            PlayCtrAdapter.adaptSkipForward();
        }
//        void playTickActual(quint64 second);
        onPlayTickActual: { //second
            tickInSeconds = second;
        }

        ///
        /// \brief playTickPercent 播放时间百分比,
        /// \param percent 0~100的播放时间百分比
        ///
//        void playTickPercent(int percent);
    }

    Filter {
        type: ActionTypes.changeCtrlBarCover
        onDispatched: {
            console.log("====== infoStore cover "+message.value)
            coverUri = message.value
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarTitle
        onDispatched: {
            console.log("====== infoStore title "+message.value)
            title = message.value
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarAlbumName
        onDispatched: {
            console.log("====== infoStore album "+message.value)
            album = message.value
        }
    }

    Filter {
        type: ActionTypes.changeCtrlBarArtistName
        onDispatched: {
            console.log("====== infoStore artist "+message.value)
            artist = message.value
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
