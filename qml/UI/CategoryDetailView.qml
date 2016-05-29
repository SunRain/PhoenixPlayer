import QtQuick 2.4
import QuickFlux 1.0
import Material 0.3
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../QuickFlux/Adapters"
import "../"

OverlayView {
    id: singleView
    width: Const.screenWidth * 0.8
    height: parent.height * 0.8
    anchors.centerIn: parent

    property string coverUri: ""
    onCoverUriChanged: {
        if (coverUri == "")
            inner.coverUri = "../images/default_disc.png";
        else  //TODO fit for qrc
            inner.coverUri = AppUtility.qrcStrPath(singleView.coverUri);
    }
    property string categoryName: ""
    onCategoryNameChanged: {
        if (categoryName == "" || categoryName == undefined)
            inner.categoryName = qsTr("UnKnow");
        else
            inner.categoryName = categoryName;
    }
    property string hash: ""
    onHashChanged: {
        console.log("==== onHashChanged "+hash)
        LocalMusicStore.groupModel.showAudioList(hash);
    }

    signal viewClosed();

    onShowingChanged: {
        if (!showing)
            viewClosed();
    }

    RandomColor {
        id: random
    }

    QtObject {
        id: inner
        property string coverUri: "../images/default_disc.png";
        property string categoryName: qsTr("UnKnow");
    }

    Scrollbar {
        flickableItem: flickable
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.margins: Const.middleSpace
        contentWidth: flickable.width
        contentHeight: mainColum.height
        boundsBehavior: Flickable.OvershootBounds
        clip: true

        Column {
            id: mainColum
            width: parent.width
            spacing: Const.tinySpace
            Item {
                id: topBar
                width: parent.width
                height: Math.max(cover.height, topbarColumn.height)
                Image {
                    id: cover
                    width: Const.cardSize
                    height: width
                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                    fillMode: Image.PreserveAspectCrop
                    source: inner.coverUri
                }
                Column {
                    id: topbarColumn
                    anchors {
                        left: cover.right
                        leftMargin: Const.middleSpace
                        top: parent.top
                        right: parent.right
                    }
                    spacing: Const.tinySpace
                    Label {
                        id: titleLabel
                        width: parent.width
                        style: "title"
                        text: inner.categoryName
                    }
                    Label {
                        id: infoLabel
                        width: parent.width
                        style: "subheading"
                        text: LocalMusicStore.groupModel.audioMetaListCount + " " +qsTr("tracks")
                        + " , "+ qsTr("total time")+" "+LocalMusicStore.groupModel.audioMetaListTotalTime
                    }
                    Row {
                        spacing: Const.middleSpace
                        IconButton {
                            size: Const.itemHeight
                            action: Action {
                                iconName: "av/play_circle_outline"
                                name: qsTr("Play all")
                            }
                        }
                        IconButton {
                            size: Const.itemHeight
                            action: Action {
                                iconName: "content/add"
                                name: qsTr("Add to playlist")
                            }
                        }
                    }
                    Label {
                        id: displayInfo
                        width: parent.width
                        style: "body1"
                        text: "bibibibibi info bibibibiibbi"
                    }
                }
            }
            ListItem.Divider {
                width: parent.width
            }

            Repeater {
                id: musicRepeater
                model: LocalMusicStore.groupModel.audioMetaList
                delegate: MusicListItem {
                    width: parent.width
                    property var object: LocalMusicStore.groupModel.audioMetaList[index]
                    property var hash: object[MetaKey.KeyHash];
                    property string pColor
                    coverColor: pColor
                    audioMetaObject: object
                    selected: PlayCtrlBarInfoStore.currentHash == hash
                    showIndictor: selected
                    onClicked: {
                        Player.playFromLibrary(hash)
                    }
                    Component.onCompleted: {
                        random.generate();
                        pColor = random.primaryDarkColor;
                    }
                }
            }


        }
    }
}
