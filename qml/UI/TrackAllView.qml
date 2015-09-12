import QtQuick 2.2
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem

//import sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"

Item {
    id: trackAllView
    clip: true

    Component.onCompleted: {
        allTracksModel.showAllTracks();
    }

    TrackAllHeader {
        id: header
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: units.dp(48)
    }

//    MusicLibraryListModel {
//        id: allTracksModel
//        autoFetchMetadata: settings.autoFetchMetaData
//    }
    property var library: [
        "a", "b", "c", "d",
        "e", "f", "g"
    ]

    ListView {
        id: listView
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
        }
        populate: Transition {
            NumberAnimation {
                easing.type: Easing.OutBounce
                properties: "y"
                from: tracksListView.height/2
                duration: 1000
            }
        }

//        model: allTracksModel
        model: library
        delegate: viewDelegate
    }

    Scrollbar {
        flickableItem: listView
    }

    Component {
        id: viewDelegate
        ListItem.Standard {
            id: listItem

//            selected: selectedFile != undefined &&
//                      selectedFile.filePath == model.filePath

//            onClicked: {
//                if (model.isDir) {
//                    folderModel.goTo(model.filePath)
//                } else {
//                    snackbar.open("Opening " + model.fileName)
//                    Qt.openUrlExternally(model.filePath)
//                }
//            }

//            onPressAndHold: {
//                if (selected)
//                    selectedFile = undefined
//                else
//                    selectedFile = model
//            }

//            function getSongTitle() {
//                return model.trackTitle;
//            }
//            function getSubInfo() {
//                return model.trackSubTitle;
//            }

            //follow Component/TrackAllHeader.qml
            RowLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: units.dp(16)
                }

                height: parent.height - units.dp(1)
                spacing: units.dp(16)

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
//                    Layout.preferredWidth: units.dp(100)
                    text: model.trackTitle
                    style: "subheading"
                    elide: Text.ElideRight

                    color: selected ? Theme.primaryColor : Theme.light.textColor
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: units.dp(100)

                    elide: Text.ElideRight

                    text: model.artistName
                    color: Theme.light.subTextColor
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: units.dp(100)

                    elide: Text.ElideRight

                    text: model.albumName
                    color: Theme.light.subTextColor
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: units.dp(100)

                    elide: Text.ElideRight

                    text: model.albumName
                    color: Theme.light.subTextColor
                }
            }
        }

    }

}
