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
import "../QuickFlux/Scripts"
import "../"

Item {
    id: categoryPage
    width: parent ? parent.width : dp(1440)
    height: parent ? parent.height : dp(900)

    property int modelcount: LocalMusicStore.model.count
    property int gridColumns: width > Const.cardSize ? width/Const.cardSize : 1

    Component.onCompleted: {
        PlayCtrAdapter.register(Const.localMusicCtrlUid);
        LocalPlayCtrl.dummy;
    }

    QtObject {
        id: overlayInner
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

    CategoryDetailScript {
        id: sc
    }

    RandomColor {
        id: random
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
                    property var object: LocalMusicStore.model.get(index)
                    property string hash: object[LocalMusicStore.groupKeyHash]//AppUtility.groupObjectToHash(LocalMusicStore.model.get(index))
                    property string pColor
                    property string dColor
                    property string textColor
                    property string subTextColor
                    property var imgUri: object[LocalMusicStore.groupKeyImgUri]//AppUtility.groupObjectToImgUri(LocalMusicStore.model.get(index))
                    property bool uriEmpty: imgUri == "" || imgUri == undefined
                    property var name: object[LocalMusicStore.groupKeyName]//AppUtility.groupObjectToName(LocalMusicStore.model.get(index))
                    property bool nameEmpty: name == "" || name == undefined
                    Component.onCompleted: {
//                        console.log("===== categoryPage Card index "+index + " hash "+hash)
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
//                            overlayInner.pColor = card.pColor;
//                            overlayInner.dColor = card.dColor;
//                            overlayInner.textColor = card.textColor;
//                            overlayInner.subTextColor = card.subTextColor;
//                            overlayInner.imgUri = card.imgUri;
//                            overlayInner.name = card.name;
//                            overlayInner.nameEmpty = card.nameEmpty;
//                            overlayInner.hash = card.hash;
//                            overlayInner.uriEmpty = card.uriEmpty
//                            console.log("==== showAudioList hash is "+overlayInner.hash);
//                            LocalMusicStore.model.showAudioList(overlayInner.hash);
//                            overlayView.open(card)
                            AppActions.openCategoryDetailView(card, card.hash, card.name, card.imgUri);
                        }
                    }
                }
            }
        }
    }
    Scrollbar {
        flickableItem: flickable
    }

//    OverlayView {
//        id: overlayView
//        width: Const.screenWidth * 0.8
//        height: parent.height * 0.8
//        anchors.centerIn: parent
//        Rectangle {
//            anchors.fill: parent
//            color: overlayInner.dColor
//        }
//        Flickable {
//            id: overlayFlickable
//            anchors.fill: parent
//            contentWidth: parent.width
//            contentHeight: wrapper.height
//            boundsBehavior: Flickable.OvershootBounds
//            clip: true
//            Column {
//                id: wrapper
//                width: parent.width
//                spacing: Const.tinySpace
//                Item {
//                    id: overlayBanner
//                    width: parent.width - Const.tinySpace * 2
//                    x: Const.tinySpace
//                    height: Math.max(Const.cardSize, infoColumn.height)
//                    Rectangle {
//                        anchors.fill: parent
//                        z: parent.z - 1
//                        radius: 2 * Units.dp
//                        opacity: 0.2
//                    }
//                    Image {
//                        id: coverImg
//                        height: parent.height // * 0.8
//                        width: height
//                        anchors {
//                            left: parent.left
//                            verticalCenter: parent.verticalCenter
//                        }
//                        fillMode: Image.PreserveAspectCrop
//                        source: overlayInner.uriEmpty
//                        //TODO fit for qrc
//                                ? "../images/default_disc.png"
//                                : AppUtility.qrcStrPath(overlayInner.imgUri);
//                    }
//                    Column {
//                        id: infoColumn
//                        anchors {
//                            left: coverImg.right
//                            leftMargin: Const.tinySpace
//                            right: parent.right
//                            rightMargin: Const.middleSpace
//                            verticalCenter: parent.verticalCenter
//                        }
//                        ListItem.Standard {
//                            width: parent.width
//                            interactive: false
//                            text: overlayInner.nameEmpty ? qsTr("Unknown") : overlayInner.name
//                        }

//                        ListItem.Standard {
//                            width: parent.width
//                            text: qsTr("Album&Artist by")
//                            valueText: "info"
//                            interactive: false
//                        }
//                        ListItem.Standard {
//                            width: parent.width
//                            text: qsTr("Length")
//                            valueText: "time & track Num. info"
//                            interactive: false
//                        }
//                        ListItem.Standard {
//                            width: parent.width
//                            text: qsTr("Released")
//                            valueText: "date"
//                            interactive: false
//                        }
//                    }
//                }
//                Column {
//                    id: overylayColumn
//                    width: parent.width - Const.tinySpace *2
//                    x: Const.tinySpace
//                    spacing: Const.tinySpace /2
//                    Repeater {
//                        model: LocalMusicStore.model.audioMetaList
//                        delegate: MusicListItem {
//                            width: parent.width
//                            showDivider: true
//                            property var object: LocalMusicStore.model.audioMetaList[index]
//                            property var hash: object[MetaKey.KeyHash];
//                            property string pColor
//                            coverColor: overlayInner.pColor
//                            audioMetaObject: object
//                            selected: PlayCtrlBarInfoStore.currentHash == hash
//                            showIndictor: selected
//                            onClicked: {
//                                Player.playFromLibrary(hash)
//                            }
//                            Component.onCompleted: {
//                                random.generate();
//                                pColor = random.primaryDarkColor;
//                            }
//                            Rectangle {
//                                anchors.fill: parent
//                                z: parent.z - 1
//                                radius: 2 * Units.dp
//                                opacity: 0.2
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        Scrollbar {
//            flickableItem: overlayFlickable
//        }
//    }
}
