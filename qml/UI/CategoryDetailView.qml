import QtQuick 2.4
import QuickFlux 1.0
import Material 0.3
import QtQuick.Layouts 1.1
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
        if (coverUri == "") {
            inner.coverUri = "../images/default_disc.png";
            inner.useDefaultCover = true;
        } else { //TODO fit for qrc
            inner.coverUri = AppUtility.qrcStrPath(singleView.coverUri);
            inner.useDefaultCover = false;
        }
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
        property bool useDefaultCover: true
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

                Item {
                    id: cover
                    width: Const.cardSize
                    height: width
                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                    MouseArea {
                        id: coverMouse
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                    Rectangle {
                        anchors.fill: parent
                        radius: 2 * Units.dp
                        color: coverMouse.containsMouse && inner.useDefaultCover
                               ? Qt.rgba(0,0,0,0.1)
                               : Qt.rgba(0,0,0,0.03)

                        IconButton {
                            anchors{
                                top: parent.top
                                right: parent.right
                                margins: Const.tinySpace
                            }
                            size: Const.itemHeight /2
                            action: Action {
                                iconName: "file/cloud_download"
                                name: qsTr("Download cover")
                            }
                            opacity: inner.useDefaultCover ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation { duration: 100; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                    Image {
                        width: inner.useDefaultCover ? parent.width * 0.8 : parent.width
                        height: width
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectCrop
                        antialiasing: true
                        source: inner.coverUri
                    }
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
                    TextCollapsible {
                        id: displayInfo
                        width: parent.width
                        style: "body1"
                        text: "bibibibibi info bibibibiibbi"
                    }
                    ProgressBar {
                        id: infoDlProgress
                        width: parent.width
                        color: Theme.accentColor
                        SequentialAnimation on value {
                            running: true
                            loops: NumberAnimation.Infinite
                            NumberAnimation {
                                duration: 3000
                                from: 0
                                to: 1
                            }
                            PauseAnimation { duration: 1000 } // This puts a bit of time between the loop
                        }
                    }

                    Button {
                        width: parent.width
                        text: qsTr("Download infomation")
//                        action: Icon {
//                            anchors.centerIn: parent
//                            size: 32 * Units.dp
//                            name: "action/info_outline"
//                        }
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
