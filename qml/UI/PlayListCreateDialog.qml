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

Dialog {
    id: plstCreate

    property var trackList: []
    property alias plstName: titleInput.text
    title: qsTr("Create playlist")
    text: qsTr("Name") + " ["+titleInput.text +"] "+qsTr("track number")+" ["+trackList.length+"]"

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
        AppActions.savePlayList(titleInput.text, tmp);
    }
    onRejected: {

    }

    TextField {
        id: titleInput
        width: parent.width
        text: qsTr("Playlist name")
//        floatingLabel: true
        placeholderText: qsTr("playlist name")
    }
    ListItem.BaseListItem {
        width: parent.width
        height: Const.subHeaderHeight
        Label {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14 * Units.dp
            font.family: "Roboto"
            font.weight: Font.DemiBold
            color: Theme.light.subTextColor
            text: qsTr("Select music")
        }
    }
    Repeater {
        model: LocalMusicStore.allMusicModel
        delegate: CheckBox {
//            width: parent.width
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
                        if (trackList[i].idx == index) {
                            break;
                        }
                    }
                    trackList.splice(i,1);
                }
            }

            Component.onCompleted: {
                title = trackMeta[MetaKey.KeyTitle]
                if (title == undefined || title == "") {
                    title = object[MetaKey.KeyName]
                }
                if (title == undefined || title == "") {
                    title = qsTr("UnKnown");
                }
            }
        }
    }



}
