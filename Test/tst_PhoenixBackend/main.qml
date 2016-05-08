import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 360
    height: 360

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    Column {
        anchors.bottom: parent.bottom
        Button {
            text: "play"
            onClicked: {
                Ctrl.play()
            }
        }
        Button {
            text: "play ++"
            onClicked: {
                Ctrl.play(5)
            }
        }

        Button {
            text: "pause"
            onClicked: {
                Ctrl.pause()
            }
        }
        Button {
            text: "pos"
            onClicked: {
                Ctrl.setPosition(10)
            }
        }
        Button {
            text: "stop"
            onClicked: {
                Ctrl.stop()
            }
        }

    }
}
