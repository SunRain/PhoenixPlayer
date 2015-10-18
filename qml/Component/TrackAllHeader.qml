import QtQuick 2.2
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem

View {
    id: header
    z: 1
    backgroundColor: Theme.backgroundColor
    elevation: 1
    fullWidth: true
//    anchors {
//        left: parent.left
//        right: parent.right
//        top: parent.top
//    }
//    height: Units.dp(48)
    RowLayout {
        anchors {
            left: parent.left
            right: parent.right
            margins: Units.dp(16)
        }
        height: parent.height - Units.dp(1)
        spacing: Units.dp(16)
        Label {
            Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
//            Layout.preferredWidth: Units.dp(100)
            text: qsTr("Title")
            color: Theme.light.subTextColor
        }
        Label {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: Units.dp(100)
            text: qsTr("Artist")
            color: Theme.light.subTextColor
        }
        Label {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: Units.dp(100)
            text: qsTr("Album")
            color: Theme.light.subTextColor
        }
        Label {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: Units.dp(100)
            text: qsTr("Duration")
            color: Theme.light.subTextColor
        }
    }
}

