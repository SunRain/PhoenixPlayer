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

    function savePlayList(name, musicObjectList) {
        AppDispatcher.dispatch(ActionTypes.savePlst, {"name":name, "value":musicObjectList})
    }
    function openPlstModifyDlg(value) {
        AppDispatcher.dispatch(ActionTypes.openPlstModifyDlg, {"value":value})
    }
    function playPlst(name) {
        AppDispatcher.dispatch(ActionTypes.playPlst, {"name":name})
    }
}
