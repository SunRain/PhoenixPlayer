import QtQuick 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem

import "../Component"

Item {
    id: playControlBar
    width: parent ? parent.width : Units.dp(700)
    height: parent ? parent.height : Units.dp(120)
    Image {
        id: trackImage
        anchors {
            left: parent.left
            leftMargin: Units.dp(2)
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.height
        height: width
        fillMode: Image.PreserveAspectFit
        source: "qrc:///default_disc_240.png"
    }

    Row {
        id: toggleRow
        anchors {
            left: trackImage.right
            top: parent.top
            bottom: parent.bottom
        }
        spacing: Units.dp(2)

        IconButton {
            id: skipBack
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/skip_previous"
                name: "skip previous"
            }
        }
        IconButton {
            id: playPause
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height * 0.8
            action: Action {
                iconName: "av/play_arrow"
                name: "play/pause"
            }
        }
        IconButton {
            id: skipNext
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/skip_next"
                name: "skip next"
            }
        }
    }

    PlayControlSlider {
        anchors {
            left: toggleRow.right
            leftMargin: Units.dp(2)
            top: parent.top
            bottom: parent.bottom
            right: menuRow.left
            rightMargin: Units.dp(2)
        }

    }
    Row {
        id: menuRow
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            rightMargin: Units.dp(2)
        }
        spacing: Units.dp(6)
        IconButton {
            id: queue
            anchors.verticalCenter: parent.verticalCenter
            size: parent.height / 2
            action: Action {
                iconName: "av/queue_music"
                name: "play queue"
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
            action: Action {
                iconName: "av/repeat"
                name: "repeat control"
            }
        }
    }
}
