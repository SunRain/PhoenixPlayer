import QtQuick 2.0
import com.sunrain.phoenixplayer.qmlplugin 1.0

Item {
    id: controller

    property bool bindController: false
    property Item bindItem: null

    signal trackChanged
    signal playBackendStateChanged
    signal playTickChanged
    signal internalReloaded

//    Connections {
//        target: musicPlayer
//        onPlayBackendStateChanged: { //int state
//            console.log("=== onPlayBackendStateChanged " + state);
//            internal.playBackendState = state;
//            if (state == Common.PlayBackendPlaying) {
//                internal.isPlaying = true;
//            } else {
//                internal.isPlaying = false;
//            }
//            if (!internal._useBind())
//                controller.playBackendStateChanged();
//        }
//        //void playTickPercent(int percent);
//        onPlayTickPercent: {
//            internal.playTickPercent = percent
//            if (!internal._useBind())
//                controller.playTickChanged();
//        }
//        onPlayTickActual: {
//            //void playTickActual(quint64 second);
//            internal.playTickActualSec = second;
//            if (!internal._useBind())
//                controller.playTickChanged();
//        }
//        onTrackChanged: {
//            console.log("===================== onTrackChanged");
////            internal.playingSongHash = musicLibraryManager.playingSongHash();
//            internal._reload();
//            trackChanged();
//        }
//    }

    QtObject {
        id: internal
        property bool isPlaying: musicPlayer.playBackendState == Common.PlayBackendPlaying
        property real playTickPercent: 0
        property int playTickActualSec: 0
//        property var playingSongHash: undefined
        property var trackTitle
        property var trackArtist
        property var trackAlbum
        property var trackLength
        property int playBackendState: Common.PlayBackendStopped

        Component.onCompleted:  {
//            playingSongHash = musicLibraryManager.playingSongHash();
            _reload();
        }

//        onPlayingSongHashChanged: {
////            trackTitle = musicLibraryManager.querySongTitle(playingSongHash);
////            trackArtist = musicLibraryManager.queryOneByIndex(playingSongHash, Common.E_ArtistName, true);
////            trackAlbum = musicLibraryManager.queryOneByIndex(playingSongHash, Common.E_AlbumName, true)
////            trackLength = musicLibraryManager.queryOneByIndex(playingSongHash, Common.E_SongLength);
////            if (!internal._useBind())
////                controller.trackChanged();
//            _reload();
//        }

        function _useBind() {
            return controller.bindController && (controller.bindItem != null)
        }
        function _reload() {
            console.log("=============== internal._reload()");
//            trackTitle = musicLibraryManager.querySongTitle(playingSongHash);
//            trackArtist = musicLibraryManager.queryOneByIndex(playingSongHash, Common.E_ArtistName, true);
//            trackAlbum = musicLibraryManager.queryOneByIndex(playingSongHash, Common.E_AlbumName, true)
//            trackLength = musicLibraryManager.queryOneByIndex(playingSongHash, Common.E_SongLength);
            trackTitle = musicPlayer.playList.currentTrack.trackMeta.title;
            trackAlbum = musicPlayer.playList.currentTrack.albumMeta.name;
            trackArtist = musicPlayer.playList.currentTrack.artistMeta.name;
            trackLength = musicPlayer.playList.currentTrack.trackMeta.duration;

            console.log("== track title " + trackTitle + " album " + trackAlbum + " artist " + trackArtist
                        + " duration " + trackLength);

            if (!internal._useBind())
                controller.trackChanged();
            controller.internalReloaded();
        }
    }

    function reloadInternalValue() {
        if (internal._useBind()) bindItem.reloadInternalValue();
        internal._reload();
    }

    function isPlaying() {
        if (internal._useBind()) return bindItem.isPlaying();
        return internal.isPlaying;
    }
    function isLocalMusic() {
        if (internal._useBind()) return bindItem.isLocalMusic();
        return true;
    }

    function getTrackUUID() {
        if (internal._useBind()) return bindItem.getTrackUUID();
        return musicPlayer.playList.currentTrack.hash//internal.playingSongHash;
    }
    function getPlayBackendState() {
        if (internal._useBind()) return bindItem.getPlayBackendState();
        return internal.playBackendState;
    }
    function getTrackLength() {
        if (internal._useBind()) return bindItem.getTrackLength();
        return internal.trackLength;
    }
    function getCoverUri(defaultUri) {
        if (internal._useBind()) return bindItem.getCoverUri();
        //TODO need update to match new  api
        var coverUri = appUtil.adjustCoverUri(musicLibraryManager.querySongImageUri(internal.playingSongHash), defaultUri);
        return coverUri;
    }
    function trackTitle() {
        if (internal._useBind()) return bindItem.trackTitle();
        return internal.trackTitle;
    }
    function trackArtist() {
        if (internal._useBind()) return bindItem.trackArtist();
        return internal.trackArtist;
    }
    function trackAlbum() {
        if (internal._useBind()) return bindItem.trackAlbum();
        return internal.trackAlbum;
    }

    function playTickPercent() {
        if (internal._useBind()) return bindItem.playTickPercent();
        return internal.playTickPercent;
    }
    function playTickActualSec() {
        if (internal._useBind()) return bindItem.playTickActualSec();
        return internal.playTickActualSec;
    }

    function togglePlayPause() {
        if (internal._useBind()) return bindItem.togglePlayPause();
        return musicPlayer.togglePlayPause();
    }
    function skipForward() {
        if (internal._useBind()) return bindItem.skipForward();
        return musicPlayer.skipForward();
    }
    function skipBackward() {
        if (internal._useBind()) return bindItem.skipBackward();
        return musicPlayer.skipBackward();
    }

    function forwardTrackName() {
//        if (internal._useBind()) return bindItem.forwardTrackName();
//        var hash = musicPlayer.forwardTrackHash();
//        var t = musicLibraryManager.querySongTitle(hash);
//        if (t == undefined || t == "")
//            return qsTr("UnKnow");
//        return t;
    }
    function forwardTrackInfo() {
//        if (internal._useBind()) return bindItem.forwardTrackInfo();
//        var hash = musicPlayer.forwardTrackHash();
//        var artist = musicLibraryManager.queryOneByIndex(hash, Common.E_ArtistName);
//        if (artist == undefined || artist == "")
//            artist = qsTr("UnKnow");
//        var time = musicLibraryManager.queryOneByIndex(hash, Common.E_SongLength);
//        if (time == undefined || time == "")
//            time = qsTr("UnKnow");
//        else
//            time = util.formateSongDuration(time);
//        return artist + " / " + time;
    }

    function backwardTrackName() {
//        if (internal._useBind()) return bindItem.backwardTrackName();
//        var hash = musicPlayer.backwardTrackHash()
//        var t = musicLibraryManager.querySongTitle(hash);
//        if (t == undefined || t == "")
//            return qsTr("UnKnow");
//        return t;
    }
    function backwardTrackInfo() {
//        if (internal._useBind()) return bindItem.backwardTrackInfo();

//        var hash = musicPlayer.backwardTrackHash();
//        var artist = musicLibraryManager.queryOneByIndex(hash, Common.E_ArtistName);
//        if (artist == undefined || artist == "")
//            artist = qsTr("UnKnow");
//        var time = musicLibraryManager.queryOneByIndex(hash, Common.E_SongLength);
//        if (time == undefined || time == "")
//            time = qsTr("UnKnow");
//        else
//            time = util.formateSongDuration(time);
//        return artist + " / " + time;
    }

    function getPlayQueuePopoverUri() {
        if (internal._useBind()) return bindItem.getPlayQueuePopoverUri();
        return "qrc:///UI/PlayQueuePopover.qml";
    }
}
