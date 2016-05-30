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
    property string coverUri: inner.default_cover
    property int durationInSeconds: 0
    property int tickInSeconds: 0

    property string currentHash: null

    property string repeatIconName: "av/repeat/default_disc.png"
    property bool repeatIconHightlight: inner.playMode == Common.PlayModeRepeatAll
                                        ||  inner.playMode == Common.PlayModeRepeatCurrent
                                        || inner.playMode == Common.PlayModeShuffle

    property string playModeText: qsTr("PlayModeOrder")
    QtObject {
        id: inner
        //TODO use qrc
        property string default_cover: "../images/default_disc.png"
        property bool isPlaying: Player.playMode == Common.PlayBackendPlaying
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

        //PlayModeOrder PlayModeRepeatCurrent  PlayModeRepeatAll PlayModeShuffle
        readonly property int playModeCapacity: 4
        property int playModeIdx: 0
        onPlayModeIdxChanged: {
            switch(playModeIdx) {
                case 0:
                    Player.playMode = Common.PlayModeOrder;
                    playModeText = qsTr("PlayModeOrder")
                    break;
                case 1:
                    Player.playMode = Common.PlayModeRepeatCurrent;
                    playModeText = qsTr("PlayModeRepeatCurrent")
                    break;
                case 2:
                    Player.playMode = Common.PlayModeRepeatAll;
                    playModeText = qsTr("PlayModeRepeatAll")
                    break;
                case 3:
                    Player.playMode = Common.PlayModeShuffle;
                    playModeText = qsTr("PlayModeShuffle")
                    break;
                default:
                    Player.playMode = Common.PlayModeOrder;
                    playModeText = qsTr("PlayModeOrder")
            }
        }

        property int playMode: Player.playMode
        onPlayModeChanged: {
            if (playMode == Common.PlayModeRepeatAll) {
                repeatIconName = "av/repeat";
                repeatIconHightlight = true;
            } else if (playMode == Common.PlayModeRepeatCurrent) {
                repeatIconName = "av/repeat_one";
                repeatIconHightlight = true;
            } else if (playMode == Common.PlayModeShuffle) {
                repeatIconName = "av/shuffle";
                repeatIconHightlight = true;
            } else { //Common.PlayModeOrder
                repeatIconName = "av/repeat"
                repeatIconHightlight = false;
            }
        }
    }
//    AudioMetaObjectKeyName {
//        id: MetaKey
//    }

    Connections {
        target: Player
        onPlayBackendStateChanged: { //state
            inner.playBackendState = state;
        }
        onTrackChanged: { //currentTrack
            var trackMeta = currentTrack[MetaKey.KeyTrackMeta]
            durationInSeconds = trackMeta[MetaKey.KeyDuration];
            currentHash = currentTrack[MetaKey.KeyHash];
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
        onPlayModeChanged: {
            inner.playMode = Player.playMode;
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
//            coverUri = message.value
            var v = message.value;
            if (v === undefined || v === "")
                v = inner.default_cover;
            coverUri = v;
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

    Filter {
        type: ActionTypes.changePlayMode
        onDispatched: {
//            var check = Player.playMode == Common.PlayModeRepeatAll || Player.playMode == Common.PlayModeRepeatCurrent
//            if (check) {
//                if (inner.playMode == Common.PlayModeRepeatAll) {
//                    console.log("===== to PlayModeRepeatCurrent")
//                    Player.playMode = Common.PlayModeRepeatCurrent;
//                } else if (inner.playMode == Common.PlayModeRepeatCurrent) {
//                    console.log("===== to PlayModeOrder")
//                    Player.playMode = Common.PlayModeOrder;
//                }
//            } else {
//                console.log("===== to PlayModeRepeatAll")
//                Player.playMode = Common.PlayModeRepeatAll;
//            }
            var idx = inner.playModeIdx;
            inner.playModeIdx = (idx+1) % inner.playModeCapacity;
        }
    }

}
