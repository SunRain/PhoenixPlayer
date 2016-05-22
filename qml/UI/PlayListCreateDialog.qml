import QtQuick 2.2
import QuickFlux 1.0
import Material 0.3
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../"

SimpleDialog {
    id: plstCreate

    property var trackList: []
    onTrackListChanged: {
        __trackSize = trackList.length
    }

    property bool isModifyMode: false
    property string plstName: "" //isModifyMode ? PlayListStore.openedPlaylistName : titleInput.text

    property int __trackSize: 0
    /*
    * Dialog inner, onAccepted signal is received first, then Dialog parent will receive onAccepted
    * so it is ok to do something here,
    * and dialog parent will only to close dialog when receive onAccepted or onRejected
    */
    onAccepted: {
        console.log("=== plstCreate  onAccepted");
        var tmp = [];
        for(var i=0; i<trackList.length; ++i) {
            tmp.push(trackList[i].track)
        }
        AppActions.savePlayList(plstName, tmp, isModifyMode);
    }
    onRejected: {

    }
//    Component.onCompleted: {
//        AppActions.showTracksInPlst(plstName)
//    }

    headerContent: Column {
        width: parent.width
        spacing: Const.tinySpace
        Item {
            width: parent.width
            height: Const.tinySpace *2
        }
        Label {
            id: titleLabel
            width: parent.width
            wrapMode: Text.Wrap
            style: "title"
            text: isModifyMode ? qsTr("Modify playlist") : qsTr("Create playlist")
        }
        ListItem.Standard {
            visible: !isModifyMode
            enabled: !isModifyMode
            action: Icon {
                anchors.centerIn: parent
                name: "action/input"
            }
            content: TextField {
                id: titleInput
                anchors.centerIn: parent
                width: parent.width
                text: qsTr("Playlist name")
                floatingLabel: true
                placeholderText: qsTr("Playlist name")
                onTextChanged: {
                    plstName = text;
                }
            }
        }
        ListItem.Standard {
            action: Icon {
                anchors.centerIn: parent
                name: "action/info"
                color: parent.selected ? Theme.primaryColor : Theme.light.iconColor
            }
            content: Item {
                anchors.fill: parent
                Label {
                    id: selectLabel
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.pixelSize: 14 * Units.dp
                    font.family: "Roboto"
                    font.weight: Font.DemiBold
                    color: Theme.light.subTextColor
                    text: qsTr("Select music")
                }
                Label {
                    width: parent.width - selectLabel.width - Const.tinySpace
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    font.pixelSize: 14 * Units.dp
                    font.family: "Roboto"
                    font.weight: Font.DemiBold
                    horizontalAlignment: Text.AlignRight
                    color: Theme.light.subTextColor
                    text: qsTr("Name") + " ["+plstName+"] "+qsTr("track number")+" ["+__trackSize+"]"
                }
            }
        }
    }
    Repeater {
        model: LocalMusicStore.allMusicModel
        delegate: CheckBox {
            property var object: LocalMusicStore.allMusicModel.get(index)
            property var trackMeta: object[MetaKey.KeyTrackMeta]
            property string title: ""
            text: title
            checked: false
            onCheckedChanged: {
                if (checked) {
                    trackList.push({"index":index, "track":object})
                } else {
                    for(var i=0; i<trackList.length; ++i) {
                        if (trackList[i].index == index) {
                            break;
                        }
                    }
                    trackList.splice(i,1);
                }
                __trackSize = trackList.length;
            }

            Component.onCompleted: {
                title = trackMeta[MetaKey.KeyTitle]
                if (title == undefined || title == "") {
                    title = object[MetaKey.KeyName]
                }
                if (title == undefined || title == "") {
                    title = qsTr("UnKnown");
                }
//                console.log("========= plst dialog onCompleted " + PlayListStore.tracksInOpenedList.length);
                for (var i=0; i<PlayListStore.tracksInOpenedList.length; ++i) {
                    var o = PlayListStore.tracksInOpenedList[i];
//                    console.log("===== ddd "+o[MetaKey.KeyHash]);
                    if (object[MetaKey.KeyHash] == PlayListStore.tracksInOpenedList[i][MetaKey.KeyHash]) {
                        checked = true;
                        break;
                    }
                }
            }
        }
    }



}
