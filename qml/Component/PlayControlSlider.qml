import QtQuick 2.0
//import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import Material 0.2

/*Item*/Column {
    id: playControlSilder

//    height: column.height
    width: parent ? parent.width : Units.dp(700)
    spacing: Units.dp(6)

    property alias trackTitle: trackTitle.text
    property alias trackArtist: artist.text
    property alias durationInfo: durationInfo.text
    property alias durationSec: slider.maximumValue

    property int playedSec: 0

    signal playJumpTo(int newSec)

    onPlayedSecChanged: {
        if (!slider.pressed)
            slider.value = playedSec;
    }

//    Column {
//        id: column
//        width: parent.width
//        spacing: Units.dp(3)
//        anchors {
//            left: parent.left
////            top: parent.top
//            leftMargin: Units.dp(2)
//        }
        RowLayout {
            id: playInfo
            anchors {
                left: parent.left
                right: parent.right
            }
            Layout.preferredHeight: playControlSilder.height/2 - Units.dp(9)
            spacing: Units.dp(16)

            Label {
                id: trackTitle
                Layout.alignment: Qt.AlignVCenter
                style: "title"
                text: "track title"
            }
            Label {
                id: artist
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
                style: "title"
                text: "artist"
            }
            Label {
                id: durationInfo
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                style: "title"
                text: "duration info"
            }
        }
//        Item {
//            id: sliderWrapper
//            width: parent.width
//            height: playControlSilder.height /3

            Slider {
                id: slider
                width: parent.width - Units.dp(50)
//                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                value: 0
                stepSize: 1
                minimumValue: 0
                maximumValue: 100
                numericValueLabel: true
                knobLabel: "aa:bb" //"bb:b " + value
                knobDiameter: Units.dp(42)

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
//                        jumpValue = 0;
                    }
                }
//            }
        }
//    }
}
