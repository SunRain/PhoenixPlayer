import QtQuick 2.2
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

import "../Component"

/*Flickable*/Sidebar {
    id: flickable
//    width: parent ? parent.width : Units.dp(250)
//    height: parent ? parent.height : Units.dp(800)

//    contentWidth: parent.width
//    contentHeight: column.height

    Column {
        id: column
        width: parent.width
        ListItem.Subheader {
            text: qsTr("Local Music")
        }
        Repeater {
            id: musicRepeater
            property int selectedSection: 0
            model: inner.sidebarLocalTitles.length //size of sectionTitles
            delegate: ListItem.Standard {
                width: parent.width
                text: inner.sidebarLocalTitles[index]
                selected: musicRepeater.selectedSection == index
                iconName: inner.sidebarLocalIconNames[index]
                onClicked: {
                    musicRepeater.selectedSection = index
                }
            }
        }
        ListItem.Divider {}
        ListItem.SectionHeader {
            text: qsTr("Addon")
        }
        ListItem.Divider {}
        ListItem.SectionHeader {
            id: recentHeader
            text: qsTr("Recent")
            expanded: true
//            ThinDivider {
//                width: parent.width
//                anchors.top: parent.top
//                visible: parent.expanded
//            }
        }
        Repeater {
            id: musicRepeater2
            property int selectedSection: 0
            model: recentHeader.expanded ? inner.sidebarLocalTitles.length : 0//size of sectionTitles
            delegate: ListItem.Standard {
                width: parent.width
                text: inner.sidebarLocalTitles[index]
                selected: musicRepeater2.selectedSection == index
                iconName: inner.sidebarLocalIconNames[index]
                onClicked: {
                    musicRepeater2.selectedSection = index
                }
            }
        }
        ListItem.Divider {}
        ListItem.Subheader {
            text: qsTr("Playlist")
        }
    }
}
