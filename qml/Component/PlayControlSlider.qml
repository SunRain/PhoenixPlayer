import QtQuick 2.0
//import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import Material 0.2

import ".."
Column {
    id: playControlSilder

    width: parent ? parent.width : dp(700)
//    spacing: dp(6)

    property string trackTitle: qsTr("UnKnow")
    property string trackArtist: qsTr("UnKnow")
    property alias durationInfo: durationInfo.text
    property alias durationSec: slider.maximumValue

    property int playedSec: 0

    signal playJumpTo(int newSec)

    onPlayedSecChanged: {
        if (!slider.pressed)
            slider.value = playedSec;
    }

    Item {
        width: parent.width - dp(100)
        height: title.height * 2
        anchors {
            left: parent.left
            leftMargin: dp(50)
        }

        Label {
            id: title
            anchors {
                left: parent.left
//                top: parent.top
                verticalCenter: parent.verticalCenter
            }
            style: "title"
            text: trackTitle
        }
        Label {
            id: artist
            anchors {
                left: title.right
                leftMargin: dp(Const.tinySpace)
//                top: parent.top
                verticalCenter: parent.verticalCenter
                right: durationInfo.left
                rightMargin: dp(Const.tinySpace)
            }
            style: "subheading"
            text: " "+qsTr("-")+" "+trackArtist
        }
        Label {
            id: durationInfo
            anchors {
                right: parent.right
//                top: parent.top
                verticalCenter: parent.verticalCenter
            }

            style: "title"
            text: "duration info"
        }
    }

    Item {
        width: parent.width
        height: slider.height
        Slider {
            id: slider
            width: parent.width - dp(50)
            anchors{
//                verticalCenterOffset: - dp(Const.tinySpace)
                top: parent.top
                //(dp(54) - dp(32))/2  from material style
                topMargin: -dp(11)
                horizontalCenter: parent.horizontalCenter
            }
            value: 0
            stepSize: 1
            minimumValue: 0
            maximumValue: 100
            numericValueLabel: true
            knobLabel: util.formateSongDuration(slider.value)//"aa:bb" //"bb:b " + value
            knobDiameter: dp(42)

            property int jumpValue: 0

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
                    playControlSilder.playJumpTo(jumpValue);
                }
            }
        }
    }
}
