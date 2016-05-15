import QtQuick 2.4
import QuickFlux 1.0
import Material 0.3
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import com.sunrain.phoenixplayer.qmlplugin 1.0

import "../Component"
import "../Component/MaterialMod"
import "../UI"
import "../QuickFlux/Actions"
import "../QuickFlux/Stores"
import "../"

PageSidebar {
    width: parent.width
    height: parent.height

    Rectangle {
        anchors.margins: dp(2)
        anchors.fill: parent
        color: theme.backgroundColor

        Item {
            width: parent.width
            height: width
            Image {
                id: coverImage
                anchors.fill: parent
                z: parent.z -1
                fillMode: Image.PreserveAspectCrop
                source: PlayCtrlBarInfoStore.coverUri
                opacity: 0.8
            }
            Rectangle {
                id: mask
                width: parent.width
                height: parent.width * 0.4
                anchors.bottom: parent.bottom
                color: Qt.rgba(0,0,0,0.3)
            }
            Slider {
                id: slider
                width: parent.width
                anchors.verticalCenter: mask.top
                value: 0
                stepSize: 1
                minimumValue: 0
                maximumValue: PlayCtrlBarInfoStore.durationInSeconds
                numericValueLabel: true
                knobLabel: util.formateSongDuration(slider.value)//"aa:bb" //"bb:b " + value
                knobDiameter: dp(42)

                property int jumpValue: 0
                onJumpValueChanged: {
                    Player.setPosition(jumpValue, false)
                }

                property int playedSec: PlayCtrlBarInfoStore.tickInSeconds
                onPlayedSecChanged: {
                    if (!slider.pressed)
                        slider.value = playedSec;
                }

                onValueChanged: {
                    console.log("=== slider change value to " + value);
                    if (slider.pressed) {
                        console.log("=== slider pressed true");
                        jumpValue = value;
                    }
                }
                onPressedChanged: {
                    console.log("=== slider onPressedChanged " + slider.pressed);
                    if (!slider.pressed && jumpValue > 0) {
                        console.log("== slider jump to value " + jumpValue);
                        slider.value = jumpValue;
//                        playControlSilder.playJumpTo(jumpValue);
                    }
                }
            }

            IconButton {
                id: playPaus
                size: mask.height * 0.5
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: Const.tinySpace
                }
                color: theme.accentColor
                iconName: PlayCtrlBarInfoStore.playPauseIcon//_isPlaying ? "av/pause" :"av/play_arrow"
                onClicked: {
                        AppActions.togglePlayPause();
                }
            }

        }
    }


}
