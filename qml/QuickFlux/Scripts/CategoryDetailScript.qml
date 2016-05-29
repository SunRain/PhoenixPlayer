import QtQuick 2.2
import QuickFlux 1.0
import QtQuick.Dialogs 1.2

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Actions"
import "../Stores"

Item {
    id: categoryDetailScript

    AppScript {
        runWhen: ActionTypes.openCategoryDetailView
        script: {
//            var name = message.name;
            var viewParent = message.viewParent;
            var hash = message.hash;
            var name = message.name;
            var cover = message.cover;
            console.log("===== script hash "+hash);

            var component = Qt.createComponent(Qt.resolvedUrl("../../UI/CategoryDetailView.qml"));
            if (component) {
                if (component.status === Component.Ready) {
                    var dlg = component.createObject(categoryDetailScript,
                                                     {"coverUri":cover,
                                                         "categoryName":name,
                                                         "hash":hash});
                    if (dlg) {
                        dlg.open(viewParent);
                    } else {
                        console.error("Can't open PlayListCreateDialog.qml");
                    }
                }
            }
            once(dlg.onViewClosed, function(){
                console.log("====== categoryDetailScript onClosed");
                dlg.destroy();
                dlg = null;
                component.destroy();
                component = null;
                exit.bind(this,0);
            })
        }
    }
}
