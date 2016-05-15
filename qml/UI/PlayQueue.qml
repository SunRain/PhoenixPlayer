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

    Flickable {
        id: flickable
        width: parent.width - Const.tinySpace * 2
        x: Const.tinySpace
        height: parent.height
        contentWidth: parent.width
        contentHeight: column.height
        Column {
            id: column
            width: parent.width
            ListItem.Subheader {
                height: Const.itemHeight * 0.8
                margins: 0
                text: qsTr("Current play queue")
                showDivider: true
            }
            Repeater {
                model: PlayListStore.queueModel
                delegate: ListItem.BaseListItem {
                    id: musicItem
                    property var object: PlayListStore.queueModel.get(index)
                    property var hash: object[MetaKey.KeyHash];
                    property var trackMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyTrackMeta, object)
                    property var coverMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyCoverMeta, object)
                    property var artistMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyArtistMeta, object)
                    property var albumMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyAlbumMeta, object)
                    property string title: "UnKnown"
                    width: parent.width
                    height: Const.itemHeight * 0.8
                    selected: PlayCtrlBarInfoStore.currentHash == hash && index == PlayListStore.playingIdx
                    Rectangle {
                        id: indicator
                        height: parent.height
                        width: dp(4)
                        anchors.left: parent.left
                        color: theme.accentColor
                        visible: musicItem.selected
                    }
                    Label {
                        anchors.left: indicator.right
                        anchors.leftMargin: Const.tinySpace
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        style: "subheading"
                        text: musicItem.title
                        color: musicItem.selected ? theme.primaryColor : Theme.light.textColor
                    }
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
