pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "QuickFlux/Actions"
import "."
AppListener {
    id: localPlayCtrl

    property string dummy: "bibibibi"
    Filter {
        type: ActionTypes.adaptSkipBackward
        onDispatched: {
            var uid = message.uid;
            console.log("==== localPlayCtrl ActionTypes.adaptSkipBackward uid "+uid);
            if (uid == Const.localMusicCtrlUid) {
                console.log("==== localPlayCtrl ActionTypes.adaptSkipBackward is local uid");
//                AppDispatcher.dispatch(AppActions.doSkipBackward);
                Player.skipBackward();
            }
        }
    }
}
