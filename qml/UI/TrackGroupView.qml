import QtQuick 2.2
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"

GridView {
    id: trackGroupView

    property var pageType
    onPageTypeChanged: {
        console.log("change page type to "+ pageType)
    }

    width: parent ? parent.width : dp(1280)
    height: parent ? parent.height : dp(800)
    clip: true
    cellWidth: trackGroupView.width / 6
    cellHeight: trackGroupView.height/ 4

    signal clicked(var groupName)

    Connections {
        target: localMusicScanner
        onSearchingFinished: {
            trackGroupModel.type = trackGroupView.pageType
        }
    }

    Scrollbar {
        flickableItem: trackGroupView
    }

    TrackGroupModel {
        id: trackGroupModel
        type: trackGroupView.pageType
    }

    delegate: delegate
    model: trackGroupModel

    add: Transition { NumberAnimation { properties: "x" } }
    remove: Transition { NumberAnimation { properties: "x" } }

    Component {
        id: delegate
        Rectangle {
            width: trackGroupView.cellWidth
            height: trackGroupView.cellHeight
            border.color: "black"

//            Image {
//                id: cover
//                width: parent.width - dp(6)
//                height: width
//                x: dp(3)
//                y: dp(3)
//                source: model.imageUri //appUtil.adjustCoverUri(model.imageUri, "images/cover-big.png", true);
//            }
            Label {
                text: model.groupName
            }
        }
    }
}
