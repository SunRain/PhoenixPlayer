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
                        inner.pColor = pColor;
                        inner.dColor = dColor;
                        inner.textColor = textColor;
                        inner.subTextColor = subTextColor;
                        inner.imgUri = imgUri;
                        inner.name = name;
                        inner.nameEmpty = nameEmpty;
                    }
                    Rectangle {
                        anchors.fill: parent
                        color: pColor
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
                                color: dColor
                                opacity: uriEmpty ? 1 : 0
                                Label {
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: nameEmpty ? "?" : name.substring(0,1)
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
                            text: AppUtility.groupObjectToName(LocalMusicStore.model.get(index))
                            textColor: textColor
                        }
                    }
                    Ink {
                        id: ink
                        anchors.fill: parent
                        enabled: true
                        onClicked: {
                            overlayView.open(card)
                        }
                    }
                    OverlayView {
                        id: overlayView
                        width: Const.cardSize * 3
                        height: parent.height * 0.8
                        anchors.centerIn: categoryPage
                        Rectangle {
                            width: parent.width
                            height: childrenRect.height
                            color: pColor
                            Label {
                                width: parent.width
                                anchors.verticalCenter: parent.verticalCenter
                                text: nameEmpty ? "?" : name.substring(0,1)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Image.AlignVCenter
                                style: "body2"
                                font.pixelSize: parent.width * 0.5
                            }
                            Image {
                                width: parent.width
                                height: implicitHeight
                                fillMode: Image.PreserveAspectFit
                                source: AppUtility.qrcStrPath(imgUri);
                            }
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
//        width: Const.cardSize * 3
//        height: parent.height * 0.8
//        anchors.centerIn: parent
//        Rectangle {
//            width: parent.width
//            height: childrenRect.height
//            color: inner.pColor
//            Label {
//                width: parent.width
//                anchors.verticalCenter: parent.verticalCenter
//                text: inner.nameEmpty ? "?" : inner.name.substring(0,1)
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Image.AlignVCenter
//                style: "body2"
//                font.pixelSize: parent.width * 0.5
//            }
//            Image {
//                width: parent.width
//                fillMode: Image.PreserveAspectFit
//                source: AppUtility.qrcStrPath(inner.imgUri);
//            }
//        }
//    }
}
