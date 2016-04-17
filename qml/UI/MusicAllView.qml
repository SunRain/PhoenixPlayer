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
        delegate: ListItem.BaseListItem {
            id: listItem
            width: parent.width
            height: Const.itemHeight
            property var object: LocalMusicStore.model.get(index)
            property var trackMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyTrackMeta, object))
            property var coverMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyCoverMeta, object))
            property var artistMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyArtistMeta, object))
            property var albumMeta: JSON.parse(AppUtility.pareseAudioMetaObject(metaKey.KeyAlbumMeta, object))
            property string pColor
            property string textColor
            property string trackTitle: qsTr("UnKnown")
            property string trackChar: "?"
            Component.onCompleted: {
                trackTitle = AppUtility.pareseAudioMetaObject(metaKey.KeyTitle, trackMeta);
                if (trackTitle == undefined || trackTitle == "") {
                    trackTitlet = AppUtility.pareseAudioMetaObject(metaKey.KeyName, object);
                }
                if (trackTitle == undefined || trackTitle == "") {
                    trackTitle = qsTr("UnKnown");
                } else {
                    trackChar = trackTitle.substring(0,1)
                }
                random.generate();
                pColor = random.primaryDarkColor;
            }

            Rectangle {
                id: cover
                height: parent.height * 0.8
                width: height
                anchors.left: parent.left
                anchors.leftMargin: Const.tinySpace
                anchors.verticalCenter: parent.verticalCenter
                color: pColor
                Label {
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    text: trackChar
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    style: "body2"
                    font.pixelSize: parent.width * 0.5
                }
                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    source :{
                        var t = AppUtility.pareseAudioMetaObject(metaKey.KeyMiddleImg, coverMeta);
                        if (t == undefined || t == "")
                            t = AppUtility.pareseAudioMetaObject(metaKey.KeyLargeImg, coverMeta);
                        if (t == undefined || t == "")
                            t = AppUtility.pareseAudioMetaObject(metaKey.KeySmallImg, coverMeta);
                        if (t == undefined || t == "")
                            t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, artistMeta);
                        if (t == undefined || t == "")
                            t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, albumMeta);
                        return t;
                    }
                }
            }
            Column {
                anchors.left: cover.right
                anchors.leftMargin: Const.tinySpace
                anchors.right: ctrl.left
                anchors.rightMargin: Const.tinySpace
                anchors.verticalCenter: parent.verticalCenter
                spacing: Units.dp(3)
                Label {
                    elide: Text.ElideRight
                    style: "subheading"
                    maximumLineCount: 1
                    verticalAlignment: Text.AlignVCenter
                    text: trackTitle
                }
                Label {
                    color: Theme.light.subTextColor
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    style: "body1"
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 1
                    text: "bibibiibibbibi"
                }
            }

            IconButton {
                id: ctrl
                size: Const.itemHeight /2
                anchors.right: parent.right
                anchors.rightMargin: Const.tinySpace
                anchors.verticalCenter: parent.verticalCenter
                iconName: "navigation/more_vert"
                onClicked: {
                    menu.open(listItem, 0, 0)
                }
            }

            Dropdown {
                id: menu
                anchor: Item.TopRight
                width: parent.width /2
                height: options.height
                Column {
                    id: options
                    width: parent.width
                    Repeater {
                        model: 6
                        ListItem.Standard {
                            width: parent.width
                            Label {
                                text: "bbbbbb"
                            }
                            onClicked: {
                                menu.close();
                            }
                        }
                    }

                }
            }
        }

    }
    Scrollbar {
        flickableItem: listView
    }   
}
