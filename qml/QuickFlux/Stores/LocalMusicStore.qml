pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"

AppListener {
    id: localMusicStore

    property var model: groupDelegate
    property alias allMusicModel: allMusicDelegate
    property string sourceUri: Qt.resolvedUrl("../../UI/MusicCategoryView.qml")

    readonly property string groupKeyName: groupDelegate.keyName
    readonly property string groupKeyHash: groupDelegate.keyHash
    readonly property string groupKeyImgUri: groupDelegate.keyImgUri

    property alias groupModel: groupDelegate

    AllMusicDelegate {
        id: allMusicDelegate
    }

    AudioGroupDelegate {
        id: groupDelegate
        Component.onCompleted: {
            ////TODO may not showAlbumCategory after Component onCompleted
            groupDelegate.showAlbumList();
        }
    }

    QtObject {
        id: inner
        readonly property int view_category: 0
        readonly property int view_all_music: 1
        property int curViewType: view_category
        onCurViewTypeChanged: {
            console.log("=== onCurViewTypeChanged "+curViewType)
            if (curViewType == view_category) {
                model = groupDelegate;
                sourceUri = Qt.resolvedUrl("../../UI/MusicCategoryView.qml");
//                model = groupDelegate;
            } else if (curViewType == view_all_music) {
                model = allMusicDelegate;
                sourceUri = Qt.resolvedUrl("../../UI/MusicAllView.qml");
//                model = allMusicDelegate;
            }
        }
    }

    Filter {
        type: ActionTypes.showAlbumCategory
        onDispatched: {
            console.log("==== localMusicStore showAlbumCategory")
            groupDelegate.showAlbumList();
            inner.curViewType = inner.view_category;
        }
    }
    Filter {
        type: ActionTypes.showArtistCategory
        onDispatched: {
            console.log("==== localMusicStore showArtistCategory")
            groupDelegate.showArtistList();
            inner.curViewType = inner.view_category;
        }
    }
    Filter {
        type: ActionTypes.showGenresCategory
        onDispatched: {
            console.log("==== localMusicStore showGenresCategory")
            groupDelegate.showGenresList();
            inner.curViewType = inner.view_category;
        }
    }
    Filter {
        type: ActionTypes.showAllMusic
        onDispatched: {
            console.log("==== localMusicStore showAllMusic")
            inner.curViewType = inner.view_all_music;
        }
    }
    Filter {
        type: ActionTypes.localMusicScannerFinish
        onDispatched: {
            allMusicDelegate.refresh();
        }
    }
}
