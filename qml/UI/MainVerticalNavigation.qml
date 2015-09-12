import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1

import "../Component"


Column {
    id: mainVerticalNavigation
    width: parent.width
    clip: true
    spacing: Units.dp(2)
//    property bool selected: value
//    property color tintColor: value
    property int selectedIndex: 0
    Repeater {
        model: ListModel {
            ListElement {
                name: qsTr("Local")
                page: "qrc:/Pages/LocalMusicPage.qml"
                icon: "hardware/computer" //Icon from  Material
            }
            ListElement {
                name: qsTr("Addon")
                page: ""
                icon: "file/cloud" //Icon from  Material
            }
            ListElement {
                name: qsTr("Playlist")
                page: ""
                icon: "action/list" //Icon from  Material
            }
            ListElement {
                name: qsTr("Settings")
                page: "qrc:/Pages/SettingsPage.qml"
                icon: "action/settings" //Icon from  Material
            }
            ListElement {
                name: qsTr("About")
                page: ""
                icon: "action/info" //Icon from  Material
            }
        }
        delegate: Rectangle {
            id: item
            width:mainVerticalNavigation.width
            height: width

            color: Qt.tint(Qt.rgba(0,0,0,0), tintColor)
            antialiasing: true
            clip: true

            Behavior on color {
                ColorAnimation { duration: 200 }
            }

            property bool selected: index == mainVerticalNavigation.selectedIndex
            property color tintColor: item.selected
                                      ? Qt.rgba(0,0,0,0.05)
                                      : Qt.rgba(0,0,0,0)

            IconButton {
                id: button
                anchors.centerIn: parent
                size: Units.dp(48)
                action: Action {
                    iconName: model.icon
                    name: model.name
                    onTriggered: {
                        console.log("Action onTriggered")
                        mainVerticalNavigation.selectedIndex = index;
                        pageStack.replace(model.page)
                    }
                }
            }
        }
    }
}
