pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "QuickFlux/Actions"
import "."
AppListener {
    id: localPlayCtrl

    property string dummy: "bibibibi"

//    AudioMetaObjectKeyName {
//        id: MetaKey
//    }

    QtObject {
        id: inner
        property var meta: null
//        property var trackMeta: null
        property var title: null
        property var album: null
        property var artist: null
        property var cover: null
        onMetaChanged: {
            var trackMeta = meta[MetaKey.KeyTrackMeta];
            title = trackMeta[MetaKey.KeyTitle]
            if (title == undefined || title == "") {
                title = meta[MetaKey.KeyName]
            }
            if (title == undefined || title == "") {
                title = qsTr("UnKnown");
            }

            var albumMeta = meta[MetaKey.KeyAlbumMeta];
            album = albumMeta[MetaKey.KeyName];
            if (album == undefined || album == "") {
                album = qsTr("UnKnown");
            }

            var artisMeta = meta[MetaKey.KeyArtistMeta];
            artist = artisMeta[MetaKey.KeyName];
            if (artist == undefined || artist == "") {
                artist = qsTr("UnKnown");
            }

            var coverMeta = meta[MetaKey.KeyCoverMeta];
            var t = coverMeta[MetaKey.KeyMiddleImg]
            if (t == undefined || t == "")
                t = coverMeta[MetaKey.KeyLargeImg]
            if (t == undefined || t == "")
                t = coverMeta[MetaKey.KeySmallImg]
            if (t == undefined || t == "")
                t = artisMeta[MetaKey.keyUri]
            if (t == undefined || t == "")
                t = albumMeta[MetaKey.keyUri]
            cover = t;

            console.log("========= localPlayCtrl title "+ title
                        +" album "+album
                        +" artist "+artist
                        +" cover "+cover)
        }

    }
//    Connections {
//        target: Player
//        onTrackChanged: { //currentTrack
//            inner.meta = currentTrack;
//        }
//    }

    Filter {
        type: ActionTypes.adaptSkipBackward
        onDispatched: {
            var uid = message.uid;
            console.log("==== localPlayCtrl ActionTypes.adaptSkipBackward uid "+uid);
            if (uid == Const.localMusicCtrlUid) {
                console.log("==== localPlayCtrl ActionTypes.adaptSkipBackward is local uid");
//                AppDispatcher.dispatch(AppActions.doSkipBackward);
                Player.skipBackward();
            }
        }
    }
    Filter {
        type: ActionTypes.adaptSkipForward
        onDispatched: {
            var uid = message.uid;
            console.log("==== localPlayCtrl ActionTypes.adaptSkipForward uid "+uid);
            if (uid == Const.localMusicCtrlUid) {
                console.log("==== localPlayCtrl ActionTypes.adaptSkipForward is local uid");
//                AppDispatcher.dispatch(AppActions.doSkipBackward);
                Player.skipForward();
            }
        }
    }
    Filter {
        type: ActionTypes.adaptCtrlBarAlbumName
        onDispatched: {
            var uid = message.uid;
            if (uid == Const.localMusicCtrlUid) {
                inner.meta = Player.currentTrack;
                console.log("=== localPlayCtrl ActionTypes.adaptCtrlBarAlbumName is local uid value "+inner.album)
                AppActions.changeCtrlBarAlbumName(inner.album);
            }
        }
    }
    Filter {
        type: ActionTypes.adaptCtrlBarArtistName
        onDispatched: {
            var uid = message.uid;
            if (uid == Const.localMusicCtrlUid) {
                inner.meta = Player.currentTrack;
                AppActions.changeCtrlBarArtistName(inner.artist);
            }
        }
    }
    Filter {
        type: ActionTypes.adaptCtrlBarCover
        onDispatched: {
            var uid = message.uid;
            if (uid == Const.localMusicCtrlUid) {
                inner.meta = Player.currentTrack;
                AppActions.changeCtrlBarCover(inner.cover);
            }
        }
    }
    Filter {
        type: ActionTypes.adaptCtrlBarTitle
        onDispatched: {
            var uid = message.uid;
            if (uid == Const.localMusicCtrlUid) {
                inner.meta = Player.currentTrack;
                console.log("=== localPlayCtrl ActionTypes.adaptCtrlBarTitle is local uid value "+inner.title)
                AppActions.changeCtrlBarTitle(inner.title);
            }
        }
    }
}
