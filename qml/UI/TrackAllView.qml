import QtQuick 2.2
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"

Item {
    id: trackAllView
    clip: true

    Component.onCompleted: {
//        allTracksModel.showAllTracks();
    }

    TrackAllHeader {
        id: header
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: dp(48)
    }

//    MusicLibraryListModel {
//        id: allTracksModel
//        autoFetchMetadata: settings.autoFetchMetaData
//    }
//    property var library: [
//        "a", "b", "c", "d",
//        "e", "f", "g"
//    ]

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
                from: listView.height/2
                duration: 1000
            }
        }

//        model: allTracksModel
        model: musicLibraryManager.allTracks()
        delegate: viewDelegate
//        Component.onCompleted: {
//            listView.model = musicLibraryManager.allTracks();
//        }
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

            onClicked: {
                console.log("==== on click "+model.modelData.name);
                musicPlayer.playFromLibrary(model.modelData.hash);
            }

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
                    margins: dp(16)
                }

                height: parent.height - dp(1)
                spacing: dp(16)

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
//                    Layout.preferredWidth: dp(100)
                    text: model.modelData.name //model.modelData.trackMeta.title
                    style: "subheading"
                    elide: Text.ElideRight

                    color: selected ? Theme.primaryColor : Theme.light.textColor
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: dp(100)

                    elide: Text.ElideRight

                    text: model.modelData.artistMeta.name//model.artistName
                    color: Theme.light.subTextColor
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: dp(100)

                    elide: Text.ElideRight

                    text: model.modelData.albumMeta.name//model.albumName
                    color: Theme.light.subTextColor
                }

                Label {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: dp(100)

                    elide: Text.ElideRight

                    text: model.modelData.trackMeta.duration
                    color: Theme.light.subTextColor
                }
            }
        }

    }

}
