pragma Singleton
import QtQuick 2.0
import Material 0.3

QtObject {
    id: constValue
    readonly property int screenWidth: Units.dp * 1024
    readonly property int screenHeight: Units.dp * 600
    readonly property real leftEdgeMargins: Units.dp * 24
    readonly property real itemHeight: Units.dp * 48
    readonly property real subHeaderHeight: Units.dp * 48
    readonly property real tinySpace: Units.dp * 8
    readonly property real cardSize: Units.dp * 128

    readonly property string localMusicCtrlUid: "bibibibibi-this-is-localCtrl"

}
