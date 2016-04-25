import QtQuick 2.2
import QuickFlux 1.0
import QtQuick.Dialogs 1.2

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"
import "../Stores"

Item {
    id: localScanner

    FileDialog {
        id: dialog
        title: qsTr("Choose music dir")
        folder: shortcuts.music
        selectFolder: true
    }

    LocalMusicScanner {
        id: localMusicScanner
    }

    AppScript {
        runWhen: ActionTypes.selectMusicScannerDirs
        script: {
            dialog.open();
            once(dialog.onAccepted, function() {
                console.log("======== dialog.onAccepted")
//                settings.addMusicDir(dialog.folder);
//                localMusicScanner.scanLocalMusic();
                localMusicScanner.scanDir(dialog.folder);
                AppActions.showProgress();
            }).then(localMusicScanner.onSearchingFinished, function() {
                console.log("========= localMusicScanner.onSearchingFinished")
                AppActions.hideProgress();
                AppActions.notifyLocalMusicScannerFinish();
            })

            once(dialog.onRejected, exit.bind(this,0));
            once(localMusicScanner.onSearchingFinished, exit.bind(this,0));
        }
    }
}
