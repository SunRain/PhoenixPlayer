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
import "../QuickFlux/Adapters"
import "../"

Item {
    id: categoryPage
    width: parent ? parent.width : dp(1440)
    height: parent ? parent.height : dp(900)

    AudioMetaObjectKeyName {
        id: metaKey
    }
    RandomColor {
        id: random
    }
//    AudioMetaObjectParser {
//        id: parser
//    }

    Component.onCompleted: {
        PlayCtrAdapter.register(Const.localMusicCtrlUid);
        LocalPlayCtrl.dummy;
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
            property var hash: object[metaKey.KeyHash];
            property var trackMeta: object[metaKey.KeyTrackMeta]
            property var coverMeta: object[metaKey.KeyCoverMeta]
            property var artistMeta: object[metaKey.KeyArtistMeta]
            property var albumMeta: object[metaKey.KeyAlbumMeta]
            property string pColor
            property string title: null
            property string imgUri: null
            trackTitle: title
            trackChar: "?"
            coverColor: pColor
            coverImage: imgUri
            selected: PlayCtrlBarInfoStore.currentHash == hash
            Component.onCompleted: {
                title = trackMeta[metaKey.KeyTitle]
                if (title == undefined || title == "") {
                    title = object[metaKey.KeyName]
                }
                if (title == undefined || title == "") {
                    title = qsTr("UnKnown");
                    musicItem.trackChar = "?";
                }
                random.generate();
                pColor = random.primaryDarkColor;
                var t = coverMeta[metaKey.KeyMiddleImg]
                if (t == undefined || t == "")
                    t = coverMeta[metaKey.KeyLargeImg]
                if (t == undefined || t == "")
                    t = coverMeta[metaKey.KeySmallImg]
                if (t == undefined || t == "")
                    t = artistMeta[metaKey.keyUri]
                if (t == undefined || t == "")
                    t = albumMeta[metaKey.keyUri]
                imgUri = t;
//                var hash = object[metaKey.KeyHash];
                console.log("====== hash "+hash);
            }
            onClicked: {
//                var hash = object[metaKey.KeyHash];
                Player.playFromLibrary(hash);
            }
        }
    }
    Scrollbar {
        flickableItem: listView
    }   
}
