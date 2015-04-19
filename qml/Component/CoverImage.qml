import QtQuick 2.0
import Material 0.1
import sunrain.phoenixplayer.qmlplugin 1.0

CoverCircleImage {
    id: coverImage
    property alias size: coverImage.width

    signal clicked

    autoChange: true
    defaultSource: "qrc:/default_cover.png";

    height: coverImage.width
    Ink {
        anchors.fill: parent
        onClicked: {coverImage.clicked()}
    }
}

