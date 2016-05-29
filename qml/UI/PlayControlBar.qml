import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem
import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../QuickFlux/Adapters"
import "../"

View {
    id: playControlBar
    width: parent ? parent.width : dp(700)
    height: slider.height//parent ? parent.height : dp(120)

    elevation: 2
    elevationInverted: true

//    property bool _isPlaying: playerController.isPlaying()
//    property var _durationValue: playerController.getTrackLength()
//    property var _title: playerController.trackTitle()
//    property var _album: playerController.trackAlbum()
//    property var _artist: playerController.trackArtist()

//    Connections {
//        target: playerController
//        onTrackChanged: {
//            _durationValue = playerController.getTrackLength();
//            _title = playerController.trackTitle()
//            _album = playerController.trackAlbum()
//            _artist = playerController.trackArtist()
//        }
//        onPlayTickChanged: {
////            if (!_sliderPressed) {
////                slider.value = playerController.playTickActualSec();//sec;
////                playedTime.text = util.formateSongDuration(playerController.playTickActualSec());
////            }
//            console.log(" onPlayTickChanged playedSec " + playerController.playTickActualSec());
//            slider.playedSec = playerController.playTickActualSec();
//        }
//        onPlayBackendStateChanged: {
//            _isPlaying = playerController.isPlaying();
//        }
//    }

    Rectangle {
        id: trackImage
        anchors.left: parent.left
        anchors.leftMargin: dp(2)
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height * 0.8
        width: height

        radius: 2 * Units.dp

        color: theme.accentColor

        Image {
            width: parent.width * 0.8
            height: width
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
            source: PlayCtrlBarInfoStore.coverUri//"qrc:///default_disc_240.png"
        }
    }

    Row {
        id: toggleRow
        anchors.left: trackImage.right
        anchors.leftMargin: Const.tinySpace
        height: parent.height
        spacing: dp(2)

        IconButton {
            id: skipBack
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/skip_previous"
                name: "skip previous"
                onTriggered: {
                    PlayCtrAdapter.adaptSkipBackward();
                }
            }
        }
        IconButton {
            id: playPause
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height * 0.8
            action: Action {
                iconName: PlayCtrlBarInfoStore.playPauseIcon//_isPlaying ? "av/pause" :"av/play_arrow"
                name: "play/pause"
                onTriggered: {
                    AppActions.togglePlayPause();
                }
            }
        }
        IconButton {
            id: skipNext
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/skip_next"
                name: "skip next"
                onTriggered: {
                    PlayCtrAdapter.adaptSkipForward();
                }
            }
        }
    }

    PlayControlSlider {
        id: slider
        anchors {
            left: toggleRow.right
            leftMargin: dp(2)
//            top: parent.top
//            bottom: parent.bottom
            right: menuRow.left
            rightMargin: dp(2)
        }
        onPlayJumpTo: {
            //newSec
            console.log("********* onPlayJumpTo "+ newSec);
//            musicPlayer.setPosition(newSec, false);
            Player.setPosition(newSec, false)
        }

        playedSec: PlayCtrlBarInfoStore.tickInSeconds
        trackTitle: PlayCtrlBarInfoStore.title//musicPlayer.playList.currentTrack.trackMeta.title
        trackArtist: PlayCtrlBarInfoStore.artist//usicPlayer.playList.currentTrack.artistMeta.name
        durationInfo: util.formateSongDuration(PlayCtrlBarInfoStore.tickInSeconds)+"/"+util.formateSongDuration(PlayCtrlBarInfoStore.durationInSeconds)//musicPlayer.playList.currentTrack.trackMeta.duration
        durationSec: PlayCtrlBarInfoStore.durationInSeconds//_durationValue
    }
    Row {
        id: menuRow
        anchors {
            right: parent.right
            rightMargin: dp(2)
        }
        height: parent.height
        spacing: dp(6)
        IconButton {
            id: queue
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/queue_music"
                name: "play queue"
                onTriggered: {
                    queueSheet.open();
                }
            }
        }
        IconButton {
            id: volume
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/volume_up"
                name: "volume control"
            }
        }
        IconButton {
            id: lyrics
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/my_library_books"
                name: "lyrics display"
            }
        }
        IconButton {
            id: repeat
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            iconName: PlayCtrlBarInfoStore.repeatIconName//"av/repeat"
            color: PlayCtrlBarInfoStore.repeatIconHightlight ? Theme.light.iconColor : Theme.light.hintColor
            onClicked: {
                AppActions.changePlayMode();
            }
        }
    }

    PlayQueue {
        id: queueSheet
        width: parent.width * 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        height: Const.screenHeight * 0.4

    }
}
