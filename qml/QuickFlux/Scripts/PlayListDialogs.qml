import QtQuick 2.2
import QuickFlux 1.0
import QtQuick.Dialogs 1.2

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"
import "../Stores"

Item {
    id: plstDialogs

    AppScript {
        runWhen: ActionTypes.openPlstCreateDlg
        script: {
            var component = Qt.createComponent(Qt.resolvedUrl("../../UI/PlayListCreateDialog.qml"));
            if (component) {
                if (component.status === Component.Ready) {
                    var dlg = component.createObject(plstDialogs);
                    if (dlg) {
                        dlg.open();
                    } else {
                        console.error("Can't open PlayListCreateDialog.qml");
                    }
                }
            }
            once(dlg.onAccepted, function() {
                console.log("===== openPlstCreateDlg  onAccepted")
                console.log("===== openPlstCreateDlg  "+dlg.trackList.length)

                component.destroy();
                component = null;
                dlg.destroy();
                dlg = null;
                exit.bind(this,0);
            });
            once(dlg.onRejected, function(){
                console.log("===== openPlstCreateDlg  onRejected")
                component.destroy();
                component = null;
                dlg.destroy();
                dlg = null;
                exit.bind(this,0)
            });
        }
    }
    AppScript {
        runWhen: ActionTypes.openPlstModifyDlg
        script: {
            var name = message.name;

            //TODO call store directly is really ugly
            PlayListStore.tracksInOpenedList = PlayListStore.playListDelegate.openPlaylist(name);

            var component = Qt.createComponent(Qt.resolvedUrl("../../UI/PlayListCreateDialog.qml"));
            if (component) {
                if (component.status === Component.Ready) {
                    var dlg = component.createObject(plstDialogs, {"isModifyMode":true, "plstName":name});
                    if (dlg) {
                        dlg.open();
                    } else {
                        console.error("Can't open PlayListCreateDialog.qml");
                    }
                }
            }
            once(dlg.onAccepted, function() {
                console.log("===== openPlstModifyDlg  onAccepted")
                console.log("===== openPlstModifyDlg  "+dlg.trackList.length)

                component.destroy();
                component = null;
                dlg.destroy();
                dlg = null;
                exit.bind(this,0);
            });
            once(dlg.onRejected, function(){
                console.log("===== openPlstCreateDlg  onRejected")
                component.destroy();
                component = null;
                dlg.destroy();
                dlg = null;
                exit.bind(this,0)
            });
        }
    }

}
