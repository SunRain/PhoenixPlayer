import QtQuick 2.4
import QuickFlux 1.0
import Material 0.2
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../Component/MaterialMod"
import "../UI"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../"

BaseViewPage {
    id: musicViewPage

    showLibraryPathSelector: LocalMusicStore.model.count == 0

//    QtObject {
//        id: inner
//        readonly property int view_category: 0
//        readonly property int view_all_music: 1
//        property int curViewType: view_category
//        onCurViewTypeChanged: {
//            console.log("=== onCurViewTypeChanged "+curViewType)
//            if (curViewType == view_category) {
//                viewLoader.source = Qt.resolvedUrl("../UI/MusicCategoryView.qml");
//                showPathSelector = (MusicCategoryStore.model.count == 0);
//            } else if (curViewType == view_all_music) {
//                viewLoader.source = Qt.resolvedUrl("../UI/MusicAllView.qml");
//                showPathSelector = (AllMusicStore.model.count == 0);
//            }
//        }
//        property bool showPathSelector: MusicCategoryStore.model.count == 0
//    }

    Loader {
        id: viewLoader
        anchors.fill: parent
        source: LocalMusicStore.sourceUri
    }

//    AppListener {
//        id: stackListener
//        Filter {
//            type: ActionTypes.showAlbumCategory
//            onDispatched: {
//                console.log("==== musicViewPage showAlbumCategory")
//                inner.curViewType = inner.view_category;
//            }
//        }
//        Filter {
//            type: ActionTypes.showArtistCategory
//            onDispatched: {
//                console.log("==== musicViewPage showArtistCategory")
//                inner.curViewType = inner.view_category;
//            }
//        }
//        Filter {
//            type: ActionTypes.showGenresCategory
//            onDispatched: {
//                console.log("==== musicViewPage showGenresCategory")
//                inner.curViewType = inner.view_category;
//            }
//        }
//        Filter {
//            type: ActionTypes.showAllMusic
//            onDispatched: {
//                console.log("==== musicViewPage showAllMusic")
//                inner.curViewType = inner.view_all_music;
//            }
//        }

//    }
}
