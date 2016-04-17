pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"

AppListener {
    id: localMusicStore
//    property alias model: allMusicDelegate
    property var model: groupDelegate
    property string sourceUri: Qt.resolvedUrl("../../UI/MusicCategoryView.qml")
//    property int count: 0

    AllMusicDelegate {
        id: allMusicDelegate
    }

    AudioGroupDelegate {
        id: groupDelegate
    }

    QtObject {
        id: inner
        readonly property int view_category: 0
        readonly property int view_all_music: 1
        property int curViewType: view_category
        onCurViewTypeChanged: {
            console.log("=== onCurViewTypeChanged "+curViewType)
            if (curViewType == view_category) {
                sourceUri = Qt.resolvedUrl("../../UI/MusicCategoryView.qml");
            } else if (curViewType == view_all_music) {
                sourceUri = Qt.resolvedUrl("../../UI/MusicAllView.qml");
            }
        }
    }

    Filter {
        type: ActionTypes.showAlbumCategory
        onDispatched: {
            console.log("==== localMusicStore showAlbumCategory")
//            AppDispatcher.dispatch(ActionTypes.toMusicCategoryPage);
//            AppActions.toMusicCategoryPage();
            groupDelegate.showAlbumList();
            inner.curViewType = inner.view_category;
        }
    }
    Filter {
        type: ActionTypes.showArtistCategory
        onDispatched: {
            console.log("==== localMusicStore showArtistCategory")
//            AppDispatcher.dispatch(ActionTypes.toMusicCategoryPage);
//            AppActions.toMusicCategoryPage();
            groupDelegate.showArtistList();
            inner.curViewType = inner.view_category;
        }
    }
    Filter {
        type: ActionTypes.showGenresCategory
        onDispatched: {
            console.log("==== localMusicStore showGenresCategory")
//            AppDispatcher.dispatch(ActionTypes.toMusicCategoryPage);
//            AppActions.toMusicCategoryPage();
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
}
