import QtQuick 2.4
import QuickFlux 1.0
import Material 0.2
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../Component/MaterialMod"
import "../UI"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"

BaseViewPage {
    id: categoryPage

    showLibraryPathSelector: MusicCategoryStore.model.count == 0

    property int modelcount: MusicCategoryStore.model.count
    onModelcountChanged: {
        console.log("====== onModelcountChanged "+modelcount)
        columnFlow.reEvalColumns();
    }
    onWidthChanged: {
//        columnFlow.reEvalColumns();
        delayColumnFlow.restart();
    }

//    property int repeaterIdx: -1;
//    Connections {
//        target: columnFlow.repeater
//        onItemAdded: {
//            console.log("==== onItemAdded")
//        }
//    }
    Timer {
        id: delayColumnFlow
        interval: 500
        onTriggered: {
            columnFlow.reEvalColumns();
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: columnFlow.height
        contentWidth: parent.width
        ColumnFlow {
            id: columnFlow
            width: parent.width
            columns: 6
            model: MusicCategoryStore.model
            delegate: Item {
                height: column.height + Units.dp(8)
                Card {
                    width: parent.width - Units.dp(8)
                    x: Units.dp(4)
                    height: column.height
//                    Rectangle {
//                        width: parent.width
//                        height: column.height
//                        color: AppUtility.randomFromPalette(Palette.colors);
                        Column {
                            id: column
                            width: parent.width
                            spacing: Units.dp(4)
                            property var imgUri: AppUtility.groupObjectToImgUri(MusicCategoryStore.model.get(index))
                            property bool uriEmpty: imgUri == "" || imgUri == undefined
                            property var name: AppUtility.groupObjectToName(MusicCategoryStore.model.get(index))
                            property bool nameEmpty: name == "" || name == undefined
                            Item {
                                width: parent.width
                                height: width
                                Rectangle {
                                    anchors.fill: parent
                                    color: AppUtility.randomFromPalette(Palette.colors);
                                    opacity: column.uriEmpty ? 1 : 0
                                    Label {
                                        width: parent.width
                                        text: column.nameEmpty ? "?" : column.name.substring(0,1)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Image.AlignVCenter
                                        style: "display4"
                                        font.pixelSize: parent.width * 0.6
                                    }
                                }
                                Image {
                                    id: image
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                    horizontalAlignment: Image.AlignHCenter
                                    verticalAlignment: Image.AlignVCenter
                                    source: AppUtility.qrcStrPath(column.imgUri);
                                }
                            }
                            Label {
                                style: "body1"
                                width: parent.width
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                horizontalAlignment: Text.AlignHCenter
                                text: AppUtility.groupObjectToName(MusicCategoryStore.model.get(index))
                            }
                            Item {
                                width: parent.width
                                height: Units.dp(4)
                            }
//                        }
                    }
                    Ink {
                        id: ink
                        anchors.fill: parent
                        enabled: true
                    }
                }
//                Rectangle {
//                    anchors.top: parent.top
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.bottom: parent.bottom
//                    anchors.margins: Units.dp(2)
//                    color: Qt.rgba(Math.random(), Math.random(), Math.random(), Math.random())

//                    Label {
////                        fontStyles: "title"
//                        text: AppUtility.groupObjectToName(MusicCategoryStore.model.get(index))
//                    }
//                }
            }
        }
    }
    Scrollbar {
        flickableItem: flickable
    }
}
