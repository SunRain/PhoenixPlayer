import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem

import "../"
ListItem.BaseListItem {
    id: musicListItem
    width: parent ? parent.width : dp(1440)
    height: Const.itemHeight

    property alias coverColor: cover.color
    property string trackTitle: ""
    onTrackTitleChanged: {
        if (trackTitle == "" || trackTitle == undefined)
            trackChar = "?";
        else
            trackChar = trackTitle.substring(0,1)
    }
    property alias trackChar: coverLabel.text
    property alias coverImage: coverImage.source

    Rectangle {
        id: cover
        height: parent.height * 0.8
        width: height
        anchors.left: parent.left
        anchors.leftMargin: Const.tinySpace
        anchors.verticalCenter: parent.verticalCenter
//        color: pColor
        Label {
            id: coverLabel
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
//            text: trackChar
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            style: "body2"
            font.pixelSize: parent.width * 0.5
        }
        Image {
            id: coverImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
//            source :{
//                var t = AppUtility.pareseAudioMetaObject(metaKey.KeyMiddleImg, coverMeta);
//                if (t == undefined || t == "")
//                    t = AppUtility.pareseAudioMetaObject(metaKey.KeyLargeImg, coverMeta);
//                if (t == undefined || t == "")
//                    t = AppUtility.pareseAudioMetaObject(metaKey.KeySmallImg, coverMeta);
//                if (t == undefined || t == "")
//                    t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, artistMeta);
//                if (t == undefined || t == "")
//                    t = AppUtility.pareseAudioMetaObject(metaKey.keyUri, albumMeta);
//                return t;
//            }
        }
    }

    Column {
        anchors.left: cover.right
        anchors.leftMargin: Const.tinySpace
        anchors.right: ctrl.left
        anchors.rightMargin: Const.tinySpace
        anchors.verticalCenter: parent.verticalCenter
        spacing: dp(3)
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
