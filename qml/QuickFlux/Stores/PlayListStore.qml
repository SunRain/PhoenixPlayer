pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import QSyncable 1.0

import com.sunrain.phoenixplayer.qmlplugin 1.0

AppListener {
    id: playListStore

    property var listModel: listDelegate
    property var currentIndex: listDelegate.listMgr.currentIndex
    onCurrentIndexChanged: {
        console.log(">>>>>>>>>>>>>>> playListStore currentIndex "+currentIndex)
    }

    property int count: listDelegate.count
    property var playListNames: listDelegate.listMgr.existPlayLists


    PlayListDelegate {
        id: listDelegate
    }
}
