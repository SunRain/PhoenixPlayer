import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../"

ListItem.BaseListItem {
    id: musicListItem
    width: parent ? parent.width : dp(1440)
    height: Const.itemHeight//72 * Units.dp

    property alias coverColor: cover.color
    property bool showIndictor: false
    property color indictorColor: Theme.accentColor
    property var audioMetaObject: null
    onAudioMetaObjectChanged: {
        inner.trackMeta = audioMetaObject[MetaKey.KeyTrackMeta];
        inner.coverMeta = audioMetaObject[MetaKey.KeyCoverMeta];
        inner.artistMeta = audioMetaObject[MetaKey.KeyArtistMeta];
        inner.albumMeta = audioMetaObject[MetaKey.KeyAlbumMeta];
        var title = inner.trackMeta[MetaKey.KeyTitle];
        if (title == undefined || title == "") {
            title = audioMetaObject[MetaKey.KeyName]
        }
        if (title == undefined || title == "") {
            inner.trackTitle = qsTr("UnKnown");
            inner.trackChar = "?";
        } else {
            inner.trackTitle = title;
            inner.trackChar = inner.trackTitle.substring(0,1);
        }
        var t = inner.coverMeta[MetaKey.KeyMiddleImg]
        if (t == undefined || t == "")
            t = inner.coverMeta[MetaKey.KeyLargeImg]
        if (t == undefined || t == "")
            t = inner.coverMeta[MetaKey.KeySmallImg]
        if (t == undefined || t == "")
            t = inner.artistMeta[MetaKey.keyUri]
        if (t == undefined || t == "")
            t = inner.albumMeta[MetaKey.keyUri]
        inner.coverImg = t;
    }

    QtObject {
        id: inner
        property string hash: ""
        property var trackMeta: null
        property var coverMeta: null
        property var artistMeta: null
        property var albumMeta: null
        property string trackTitle: qsTr("UnKnown")
        property string trackChar: "?"
        property string coverImg: ""
    }

//    property string trackTitle: ""
//    onTrackTitleChanged: {
//        if (trackTitle == "" || trackTitle == undefined)
//            trackChar = "?";
//        else
//            trackChar = trackTitle.substring(0,1)
//    }
//    property alias trackChar: coverLabel.text
//    property alias coverImage: coverImage.source

    Rectangle {
        id: indictor
        width: showIndictor ? 4 * Units.dp : 0
        height: parent.height
        color: indictorColor
        visible: showIndictor
        enabled: showIndictor
    }

    Rectangle {
        id: cover
        width: height
        height: parent.height
        anchors.left: indictor.right

        Label {
            id: coverLabel
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            style: "body2"
            font.pixelSize: parent.width * 0.5
            text: inner.trackChar
        }
        Image {
            id: coverImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: inner.coverImg
        }
    }
    Column {
        id: column
        anchors {
            left: cover.right
            leftMargin: Const.tinySpace
            right: ctrlBtn.left
            rightMargin: Const.tinySpace
            verticalCenter: parent.verticalCenter
        }
        spacing: 3 * Units.dp
        Label {
            width: parent.width
            elide: Text.ElideRight
            style: "body1"
            verticalAlignment: Text.AlignVCenter
            color: Theme.light.subTextColor
            text: inner.trackTitle
        }
        Label {
            width: parent.width
            color: Theme.light.subTextColor
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            style: "body1"
            text: "bibibibibibi"
        }
    }

    IconButton {
        id: ctrlBtn
        anchors {
            right: parent.right
            rightMargin: Const.tinySpace
            verticalCenter: parent.verticalCenter
        }
        iconName: "navigation/more_vert"
        onClicked: {
            menu.open(musicListItem, 0, 0)
        }
    }

    Dropdown {
        id: menu
        anchor: Item.TopRight
        width: musicListItem.width /2
        height: options.height
        Rectangle {
            anchors.fill: parent
            radius: 2 * Units.dp
        }
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
