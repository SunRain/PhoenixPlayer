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

//    AudioMetaObjectKeyName {
//        id: MetaKey
//    }

    function parser() {
        trackMeta = AppUtility.pareseAudioMetaObject(MetaKey.KeyTrackMeta, audioObject)
        coverMeta = AppUtility.pareseAudioMetaObject(MetaKey.KeyCoverMeta, audioObject)
        artistMeta = AppUtility.pareseAudioMetaObject(MetaKey.KeyArtistMeta, audioObject)
        albumMeta = AppUtility.pareseAudioMetaObject(MetaKey.KeyAlbumMeta, audioObject)
        var title = AppUtility.pareseAudioMetaObject(MetaKey.KeyTitle, trackMeta);
        if (title == undefined || title == "") {
            title = AppUtility.pareseAudioMetaObject(MetaKey.KeyName, audioObject);
        }
        if (title == undefined || title == "") {
            title = qsTr("UnKnown");
        }
        trackTitle = title;
        var t = AppUtility.pareseAudioMetaObject(MetaKey.KeyMiddleImg, coverMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(MetaKey.KeyLargeImg, coverMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(MetaKey.KeySmallImg, coverMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(MetaKey.keyUri, artistMeta);
        if (t == undefined || t == "")
            t = AppUtility.pareseAudioMetaObject(MetaKey.keyUri, albumMeta);
        coverImage = t;
        hash = AppUtility.pareseAudioMetaObject(MetaKey.KeyHash, audioObject);
    }

}
