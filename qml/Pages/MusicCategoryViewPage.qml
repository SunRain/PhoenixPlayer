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
import "../"

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
        interval: 100
        onTriggered: {
            columnFlow.reEvalColumns();
        }
    }

    RandomColor {
        id: random
    }

    Flickable {
        id: flickable
        width: parent.width - Const.tinySpace *4
        height: parent.height
        x: Const.tinySpace *2
        contentHeight: columnFlow.height
        contentWidth: width
        ColumnFlow {
            id: columnFlow
            width: parent.width
            columns: 6
            model: MusicCategoryStore.model
            delegate: Item {
                height: column.height + Const.tinySpace *2
                property string pColor
                property string dColor
                property string textColor
                property string subTextColor
                Component.onCompleted: {
                    random.generate();
                    pColor = random.primaryLightColor;
                    dColor = random.primaryDarkColor;
                    textColor = random.textColor;
                    subTextColor = random.subTextColor;
                }
                Card {
                    width: parent.width - Const.tinySpace *2
                    x: Const.tinySpace
                    height: column.height
                    Rectangle {
                        anchors.fill: parent
                        color: pColor
                    }
                    Column {
                        id: column
                        width: parent.width
                        spacing: Const.tinySpace
                        property var imgUri: AppUtility.groupObjectToImgUri(MusicCategoryStore.model.get(index))
                        property bool uriEmpty: imgUri == "" || imgUri == undefined
                        property var name: AppUtility.groupObjectToName(MusicCategoryStore.model.get(index))
                        property bool nameEmpty: name == "" || name == undefined
                        Item {
                            width: parent.width
                            height: width
                            Rectangle {
                                anchors.fill: parent
                                color: dColor
                                opacity: column.uriEmpty ? 1 : 0
                                Label {
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: column.nameEmpty ? "?" : column.name.substring(0,1)
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
                                source: AppUtility.qrcStrPath(column.imgUri);
                            }
                        }
                        ListItem.Standard {
                            width: parent.width
                            height: Const.itemHeight
                            text: AppUtility.groupObjectToName(MusicCategoryStore.model.get(index))
                            textColor: textColor
                        }
                    }
                    Ink {
                        id: ink
                        anchors.fill: parent
                        enabled: true
                    }
                }
            }
        }
    }
    Scrollbar {
        flickableItem: flickable
    }
}
