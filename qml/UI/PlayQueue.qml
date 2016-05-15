import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../QuickFlux/Adapters"
import "../"

BottomSheet {
    id: playQueue

    width: parent ? parent.width : Const.screenWidth
    height: parent ? parent.height : Const.screenHeight

//    AudioMetaObjectKeyName {
//        id: MetaKey
//    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: column.height
        Column {
            id: column
            width: parent.width
            Repeater {
                model: PlayListStore.listModel
                delegate: ListItem.Standard {
                    property var object: PlayListStore.listModel.get(index)
                    property var hash: object[MetaKey.KeyHash];
                    property var trackMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyTrackMeta, object)
                    property var coverMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyCoverMeta, object)
                    property var artistMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyArtistMeta, object)
                    property var albumMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyAlbumMeta, object)
                    property string title: "UnKnown"
                    width: parent.width
                    text: title
                    selected: PlayCtrlBarInfoStore.currentHash == hash && index == PlayListStore.playingIdx
                    Component.onCompleted: {
                        title = AppUtility.pareseAudioMetaObject(MetaKey.KeyTitle, trackMeta);
                        if (title == undefined || title == "") {
                            title = AppUtility.pareseAudioMetaObject(MetaKey.KeyName, object);
                        }
                        if (title == undefined || title == "") {
                            title = qsTr("UnKnown");
    //                        musicItem.trackChar = "?";
                        }
                    }
                    onClicked: {
//                        Player.playFromLibrary(hash);
                        Player.playAt(index);
                    }
                }
            }
        }
    }

}
