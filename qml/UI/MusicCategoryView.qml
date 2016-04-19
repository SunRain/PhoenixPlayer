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

    property int modelcount: LocalMusicStore.model.count
    property int gridColumns: width > Const.cardSize ? width/Const.cardSize : 1

    Component.onCompleted: {
        //TODO may not showAlbumCategory after Component onCompleted
//        AppActions.showAlbumCategory();
    }

    QtObject {
        id: inner
        property string hash
        property string pColor
        property string dColor
        property string textColor
        property string subTextColor
        property var imgUri
        property bool uriEmpty: true
        property var name
        property bool nameEmpty: true
    }

    RandomColor {
        id: random
    }
    AudioMetaObjectKeyName {
        id: metaKey
    }

    Flickable {
        id: flickable
        width: gridColumns == 1 ? parent.width : Const.cardSize * gridColumns
        height: parent.height - Const.tinySpace *4
        x: (parent.width - flickable.width - columnFlow.spacing *(gridColumns-1))/2
        y: Const.tinySpace *2
        contentHeight: columnFlow.height
        contentWidth: width
        Grid {
            id: columnFlow
            columns: gridColumns
            spacing: Const.tinySpace
            Repeater {
                model: LocalMusicStore.model
                delegate: Card {
                    id: card
                    width: Const.cardSize
                    height: column.height
                    property string hash: AppUtility.groupObjectToHash(LocalMusicStore.model.get(index))
                    property string pColor
                    property string dColor
                    property string textColor
                    property string subTextColor
                    property var imgUri: AppUtility.groupObjectToImgUri(LocalMusicStore.model.get(index))
                    property bool uriEmpty: imgUri == "" || imgUri == undefined
                    property var name: AppUtility.groupObjectToName(LocalMusicStore.model.get(index))
                    property bool nameEmpty: name == "" || name == undefined
                    Component.onCompleted: {
                        random.generate();
                        pColor = random.primaryLightColor;
                        dColor = random.primaryDarkColor;
                        textColor = random.textColor;
                        subTextColor = random.subTextColor;
                    }
                    Rectangle {
                        anchors.fill: parent
                        color: card.pColor
                    }
                    Column {
                        id: column
                        width: parent.width
                        spacing: Const.tinySpace
                        Item {
                            width: parent.width
                            height: width
                            Rectangle {
                                anchors.fill: parent
                                color: card.dColor
                                opacity: card.uriEmpty ? 1 : 0
                                Label {
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: card.nameEmpty ? "?" : card.name.substring(0,1)
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Image.AlignVCenter
                                    style: "display3"
                                    font.pixelSize: parent.width * 0.5
                                }
                            }
                            Image {
                                id: image
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                                horizontalAlignment: Image.AlignHCenter
                                verticalAlignment: Image.AlignVCenter
                                source: AppUtility.qrcStrPath(imgUri);
                            }
                        }
                        ListItem.Standard {
                            width: parent.width
                            height: Const.itemHeight
                            text: card.nameEmpty ? qsTr("UnKnown") : card.name
                            textColor: textColor
                        }
                    }
                    Ink {
                        id: ink
                        anchors.fill: parent
                        enabled: true
                        onClicked: {
                            inner.pColor = card.pColor;
                            inner.dColor = card.dColor;
                            inner.textColor = card.textColor;
                            inner.subTextColor = card.subTextColor;
                            inner.imgUri = card.imgUri;
                            inner.name = card.name;
                            inner.nameEmpty = card.nameEmpty;
                            inner.hash = card.hash;
                            console.log("==== showAudioList hash is "+inner.hash);
                            LocalMusicStore.model.showAudioList(inner.hash);
                            overlayView.open(card)
                        }
                    }
                }
            }
        }
    }
    Scrollbar {
        flickableItem: flickable
    }

    OverlayView {
        id: overlayView
        width: Const.cardSize * 3
        height: parent.height * 0.8
        anchors.centerIn: parent
        Rectangle {
            anchors.fill: parent
            color: inner.pColor
        }
        Flickable {
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: overlayBanner.height + overylayColumn.height
            boundsBehavior: Flickable.OvershootBounds
            clip: true
            Item {
                id: overlayBanner
                width: parent.width
                height: Const.cardSize
                Rectangle {
                    anchors.fill: parent
                    color: inner.dColor
                    Label {
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        text: inner.nameEmpty ? qsTr("UnKnown") : inner.name.substring(0,1)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        style: "body2"
                        font.pixelSize: parent.height * 0.5
                    }
                }
                Image {
                    id: overlayImage
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: AppUtility.qrcStrPath(inner.imgUri);
                }
            }
            Column {
                id: overylayColumn
                width: parent.width
                anchors.top: overlayBanner.bottom
                Repeater {
                    model: LocalMusicStore.model.audioMetaListModel
                    delegate: MusicListItem {
                        property var object: LocalMusicStore.model.audioMetaListModel.get(index)
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

            }
        }
    }
}
