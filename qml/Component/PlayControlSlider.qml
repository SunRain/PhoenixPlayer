import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import Material 0.1

import Material.ListItems 0.1 as ListItem


ListItem.BaseListItem {
    id: playControlSilder

    height: parent ? parent.height : units.dp(80)
    width: parent ? parent.width : units.dp(700) // mainView ApplicationWindow width - siderbar width

    property alias trackTitle: trackTitle.text
    property alias trackArtist: artist.text
    property alias durationInfo: durationInfo.text

    property int playedPercent

    signal playJumpTo(int newPercent)

    onPlayedPercentChanged: {
        if (!slider.pressed)
            slider.value = playedPercent;
    }

    ColumnLayout {
        width: parent.width
        spacing: units.dp(3)

        RowLayout {
            id: playInfo
            anchors {
                left: parent.left
                right: parent.right
            }
            Layout.preferredHeight: playControlSilder.height/2 - units.dp(9)
            spacing: units.dp(16)

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

        Slider {
            id: slider
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.preferredHeight: playControlSilder.height /3
            value: 0
            stepSize: 1
            minimumValue: 0
            maximumValue: 100
            numericValueLabel: true

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
                    jumpValue = 0;
                }
            }
        }
    }
}
