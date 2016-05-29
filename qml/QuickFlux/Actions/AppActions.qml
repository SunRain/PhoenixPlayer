pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

import "./"

ActionCreator {
    signal showProgress();
    signal hideProgress();
    signal selectMusicScannerDirs();
//    signal localMusicScannerFinish();

//    signal toMusicCategoryPage();
//    signal toAllMusicPage();

    signal showAlbumCategory();
    signal showArtistCategory();
    signal showGenresCategory();
    signal showAllMusic();

    signal changePlayMode();

    signal openPlstCreateDlg();

    function togglePlayPause() {
        Player.togglePlayPause();
    }
    function notifyLocalMusicScannerFinish() {
        AppDispatcher.dispatch(ActionTypes.localMusicScannerFinish, "");
    }
    function changeCtrlBarCover(value) {
        AppDispatcher.dispatch(ActionTypes.changeCtrlBarCover, {"value":value})
    }
    function changeCtrlBarTitle(value) {
        AppDispatcher.dispatch(ActionTypes.changeCtrlBarTitle, {"value":value})
    }
    function changeCtrlBarAlbumName(value) {
        AppDispatcher.dispatch(ActionTypes.changeCtrlBarAlbumName, {"value":value})
    }
    function changeCtrlBarArtistName(value) {
        AppDispatcher.dispatch(ActionTypes.changeCtrlBarArtistName, {"value":value})
    }

    function savePlayList(name, musicObjectList, override) {
        AppDispatcher.dispatch(ActionTypes.savePlst, {"name":name, "value":musicObjectList, "override":override})
    }
    function openPlstModifyDlg(name) {
        AppDispatcher.dispatch(ActionTypes.openPlstModifyDlg, {"name":name})
    }
    function playPlst(name) {
        AppDispatcher.dispatch(ActionTypes.playPlst, {"name":name})
    }
    function showTracksInPlst(name) {
        AppDispatcher.dispatch(ActionTypes.showTracksInPlst, {"name":name});
    }

    function openCategoryDetailView(parent, hash, name, cover) {
        AppDispatcher.dispatch(ActionTypes.openCategoryDetailView,
                               {"viewParent":parent,
                                   "hash":hash,
                                   "name":name,
                                   "cover":cover});
    }
}
