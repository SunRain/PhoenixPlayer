pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"

AppListener {
    property alias model: groupDelegate

    AudioGroupDelegate {
        id: groupDelegate
    }

    Filter {
        type: ActionTypes.showAlbumCategory
        onDispatched: {
            console.log("==== MusicCategoryStore showAlbumCategory")
//            AppDispatcher.dispatch(ActionTypes.toMusicCategoryPage);
//            AppActions.toMusicCategoryPage();
            groupDelegate.showAlbumList();
        }
    }
    Filter {
        type: ActionTypes.showArtistCategory
        onDispatched: {
            console.log("==== MusicCategoryStore showArtistCategory")
//            AppDispatcher.dispatch(ActionTypes.toMusicCategoryPage);
//            AppActions.toMusicCategoryPage();
            groupDelegate.showArtistList();
        }
    }
    Filter {
        type: ActionTypes.showGenresCategory
        onDispatched: {
            console.log("==== MusicCategoryStore showGenresCategory")
//            AppDispatcher.dispatch(ActionTypes.toMusicCategoryPage);
//            AppActions.toMusicCategoryPage();
            groupDelegate.showGenresList();
        }
    }
}
