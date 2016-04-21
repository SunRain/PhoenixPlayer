pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"

Item {
    id: adapter

    QtObject {
        id: inner
        property string uid: "bibibi-need-uuid"
    }

    function register(uid) {
        inner.uid = uid
    }

    function adaptCtrlBarCover() {
        AppDispatcher.dispatch(ActionTypes.adaptCtrlBarCover, {"uid":inner.uid});
    }

    function adaptCtrlBarTitle() {
        AppDispatcher.dispatch(ActionTypes.adaptCtrlBarTitle, {"uid":inner.uid});
    }

    function adaptCtrlBarAlbumName() {
        AppDispatcher.dispatch(ActionTypes.adaptCtrlBarAlbumName, {"uid":inner.uid});
    }

    function adaptCtrlBarArtistName() {
        AppDispatcher.dispatch(ActionTypes.adaptCtrlBarArtistName, {"uid":inner.uid});
    }

    function adaptSkipBackward() {
        console.log("=== adapter adaptSkipBackward uid "+inner.uid);
        AppDispatcher.dispatch(ActionTypes.adaptSkipBackward, {"uid":inner.uid});
    }

    function adaptSkipForward() {
        AppDispatcher.dispatch(ActionTypes.adaptSkipForward, {"uid":inner.uid});
    }
}
