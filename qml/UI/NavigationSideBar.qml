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

Sidebar {
    id: sidebar

    QtObject {
        id: inner
        property var sidebarLocalTitles: [
            qsTr("Album"),
            qsTr("Artist"),
            qsTr("Genres"),
            qsTr("All")
//            qsTr("Recent"),
//            qsTr("PlayList")
        ]
        property var sidebarLocalIconNames: [
            "av/album",
            "social/person",
            "av/web",
            "av/queue_music"
//            "av/queue",
//            "av/playlist_play"
        ]
    }
//    AudioMetaObjectKeyName {
//        id: MetaKey
//    }
    Column {
        id: column
        width: parent.width
        ListItem.Subheader {
            text: qsTr("Local Music")
            margins: Const.leftEdgeMargins
            height: Const.subHeaderHeight
        }
        Repeater {
            id: musicRepeater
            property int selectedIndex: 0
            model: inner.sidebarLocalTitles.length
            delegate: ListItem.Standard {
                margins: Const.leftEdgeMargins
                height: Const.itemHeight
                text: inner.sidebarLocalTitles[index]
                selected: musicRepeater.selectedIndex == index
                iconName: inner.sidebarLocalIconNames[index]
                onClicked: {
                    musicRepeater.selectedIndex = index;
                    console.log("===== musicRepeater clicked "+index)
                    switch(index) {
                    case 0:
                        AppActions.showAlbumCategory();
                        break;
                    case 1:
                        AppActions.showArtistCategory();
                        break;
                    case 2:
                        AppActions.showGenresCategory();
                        break;
                    case 3:
//                        AppActions.toAllMusicPage();
                        AppActions.showAllMusic();
                        break;
//                    default:
//                        AppActions.showAlbumCategory();
                    }

                }
            }
        }
        ListItem.Divider {}
        ListItem.SectionHeader {
            text: qsTr("Addon")
        }
        ListItem.Divider {}
        ListItem.SectionHeader {
            id: recentHeader
            text: qsTr("Recent")
        }
//        Repeater {
//            id: musicRepeater2
//            property int selectedSection: 0
//            model: recentHeader.expanded ? inner.sidebarLocalTitles.length : 0//size of sectionTitles
//            delegate: ListItem.Standard {
//                width: parent.width
//                text: inner.sidebarLocalTitles[index]
//                selected: musicRepeater2.selectedSection == index
//                iconName: inner.sidebarLocalIconNames[index]
//                onClicked: {
//                    musicRepeater2.selectedSection = index
//                }
//            }
//        }
        ListItem.Divider {}
        ListItem.Subheader {
            text: qsTr("Playlist")
        }
        Repeater {
            model: PlayListStore.listModel
            delegate: ListItem.Standard {
                property var object: PlayListStore.listModel.get(index)
                property var hash: object[MetaKey.KeyHash];
                property var trackMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyTrackMeta, object)
                property var coverMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyCoverMeta, object)
                property var artistMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyArtistMeta, object)
                property var albumMeta: AppUtility.pareseAudioMetaObject(MetaKey.KeyAlbumMeta, object)
                property string title: "UnKnown"
                width: parent.width
                text: title
                selected: PlayCtrlBarInfoStore.currentHash == hash && index == PlayListStore.currentIndex
                Component.onCompleted: {
                    title = AppUtility.pareseAudioMetaObject(MetaKey.KeyTitle, trackMeta);
                    if (title == undefined || title == "") {
                        title = AppUtility.pareseAudioMetaObject(MetaKey.KeyName, object);
                    }
                    if (title == undefined || title == "") {
                        title = qsTr("UnKnown");
//                        musicItem.trackChar = "?";
                    }
                }
                onClicked: {
                    Player.playFromLibrary(hash);
                }
            }
        }
    }
}
