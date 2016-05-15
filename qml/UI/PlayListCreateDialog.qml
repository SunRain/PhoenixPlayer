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

    property int trackSize: 0
    property var trackList: []
    title: qsTr("Create playlist")
    text: qsTr("Name") + " ["+titleInput.text +"] "+qsTr("track number")+" ["+trackSize+"]"

    onAccepted: {

    }

    TextField {
        id: titleInput
        width: parent.width
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
            onCheckedChanged: {
                if (checked) {
                    trackList.push(title)
                } else {
                    //TODO remove from array
                }
                trackSize = trackList.length;
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
