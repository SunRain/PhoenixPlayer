import QtQuick 2.4
import QuickFlux 1.0
import Material 0.2
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../"

Item {
    id: categoryPage
    width: parent ? parent.width : Units.dp(1440)
    height: parent ? parent.height : Units.dp(900)

    AudioMetaObjectKeyName {
        id: metaKey
    }
    RandomColor {
        id: random
    }

    ListView {
        id: listView
        width: parent.width - Const.tinySpace *4
        height: parent.height - Const.tinySpace *4
        x: Const.tinySpace *2
        y: Const.tinySpace *2
        model: LocalMusicStore.model
        spacing: Const.tinySpace
        delegate: MusicListItem {
            id: musicItem
            width: parent.width
            property var object: LocalMusicStore.model.get(index)
            property var trackMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyTrackMeta, object))
            property var coverMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyCoverMeta, object))
            property var artistMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyArtistMeta, object))
            property var albumMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyAlbumMeta, object))
            property string pColor
            property string title: ""
            property string imgUri: ""
            trackTitle: title
            trackChar: "?"
            coverColor: pColor
            coverImage: imgUri
            Component.onCompleted: {
                title = AppUtility.pareseAudioMetaObject(metaKey.KeyTitle, trackMeta);
                if (title == undefined || title == "") {
                    title = AppUtility.pareseAudioMetaObject(metaKey.KeyName, object);
                }
                if (title == undefined || title == "") {
                    title = qsTr("UnKnown");
                    musicItem.trackChar = "?";
                }
                random.generate();
                pColor = random.primaryDarkColor;
                var t = AppUtility.pareseAudioMetaObject(metaKey.KeyMiddleImg, coverMeta);
                if (t == undefined || t == "")
                    t = AppUtility.pareseAudioMetaObject(metaKey.KeyLargeImg, coverMeta);
                if (t == undefined || t == "")
                    t = AppUtility.pareseAudioMetaObject(metaKey.KeySmallImg, coverMeta);
                if (t == undefined || t == "")
                    t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, artistMeta);
                if (t == undefined || t == "")
                    t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, albumMeta);
                imgUri = t;
            }
        }
    }
    Scrollbar {
        flickableItem: listView
    }   
}
