import QtQuick 2.0
import com.sunrain.phoenixplayer.qmlplugin 1.0

QObject {
    id: audioParser

    property var audioObject
    onAudioObjectChanged: {
        parser();
    }
    property var trackMeta: null
    property var coverMeta: null
    property var artistMeta: null
    property var albumMeta: null
    property string trackTitle: ""
    property var coverImage: null
    property string hash: ""

    AudioMetaObjectKeyName {
        id: metaKey
    }

    function parser() {
        trackMeta = AppUtility.pareseAudioMetaObject(metaKey.KeyTrackMeta, audioObject)
        coverMeta = AppUtility.pareseAudioMetaObject(metaKey.KeyCoverMeta, audioObject)
        artistMeta = AppUtility.pareseAudioMetaObject(metaKey.KeyArtistMeta, audioObject)
        albumMeta = AppUtility.pareseAudioMetaObject(metaKey.KeyAlbumMeta, audioObject)
        var title = AppUtility.pareseAudioMetaObject(metaKey.KeyTitle, trackMeta);
        if (title == undefined || title == "") {
            title = AppUtility.pareseAudioMetaObject(metaKey.KeyName, audioObject);
        }
        if (title == undefined || title == "") {
            title = qsTr("UnKnown");
        }
        trackTitle = title;
        var t = AppUtility.pareseAudioMetaObject(metaKey.KeyMiddleImg, coverMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(metaKey.KeyLargeImg, coverMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(metaKey.KeySmallImg, coverMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, artistMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, albumMeta);
        coverImage = t;
        hash = AppUtility.pareseAudioMetaObject(metaKey.KeyHash, audioObject);
    }

}
