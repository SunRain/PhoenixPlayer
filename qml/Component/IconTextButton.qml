import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.3
import Material 0.1
Controls.Button {
    id: button
    property url iconSource
    property real iconSize

    property int elevation
    property color backgroundColor: elevation > 0 ? "white" : "transparent"
    property color textColor: Theme.lightDark(button.backgroundColor,
                                              Theme.light.textColor,
                                              Theme.dark.textColor)
    /*!
       Set to \c true if the button is on a dark background
     */
    property bool darkBackground

    style: ButtonStyle {
        padding {
            left: 0
            right: 0
            top: 0
            bottom: 0
        }

        background: View {
            id: background

            implicitHeight: units.dp(36)

            radius: units.dp(2)

            property int controlElevation: control.hasOwnProperty("elevation") ? control.elevation : 1

            elevation: {
                var elevation = controlElevation

                if (elevation > 0 && (control.focus || mouseArea.currentCircle))
                    elevation++;

                if(!control.enabled)
                    elevation = 0;

                return elevation;
            }

            property bool darkBackground: control.hasOwnProperty("darkBackground")
                    ? control.darkBackground : false

            property string context: control.hasOwnProperty("context") ? control.context : "default"

            backgroundColor: control.enabled || controlElevation === 0
                    ? control.hasOwnProperty("backgroundColor") ? button.backgroundColor
                                                                : "transparent"
                    : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                     : Qt.rgba(0, 0, 0, 0.12)

            tintColor: mouseArea.currentCircle || control.focus || control.hovered
               ? Qt.rgba(0,0,0, mouseArea.currentCircle ? 0.1
                                : elevation > 0 ? 0.03
                                : 0.05)
               : "transparent"

            Ink {
                id: mouseArea

                anchors.fill: parent
                focused: control.focus
                focusWidth: parent.width - units.dp(30)
                focusColor: Qt.darker(background.backgroundColor, 1.05)

                Connections {
                    target: control.__behavior
                    onPressed: mouseArea.onPressed(mouse)
                    onCanceled: mouseArea.onCanceled()
                    onReleased: mouseArea.onReleased(mouse)
                }
            }
        }
        label: Item {
            implicitHeight: Math.max(units.dp(36), label.height + units.dp(16))
            implicitWidth: control.hasOwnProperty("parent")
                           ? control.parent.width
                           : Math.max(units.dp(88), label.width + units.dp(32))

            Item {
                id: label
                anchors {
                    left: parent.left
                    top: parent.top
                }
                width: icon.width + label2.width + units.dp(16)
                height: Math.max(icon.height, label2.height)

                Image {
                    id: icon
                    width: {
                        if (button.iconSize == "" || button.iconSize == undefined)
                            return icon.implicitWidth;
                        return button.iconSize;
                    }
                    height: icon.width
                    source: button.iconSource

                    fillMode: Image.PreserveAspectFit
                }
                Label {
                    id: label2
                    anchors {
                        left: icon.right
                        leftMargin: units.dp(16)
                        verticalCenter: icon.verticalCenter
                    }
                    text: control.text
                    style: "button"
                    color: control.enabled ? control.hasOwnProperty("textColor")
                                             ? control.textColor : Theme.light.textColor
                    : control.darkBackground ? Qt.rgba(1, 1, 1, 0.30)
                    : Qt.rgba(0, 0, 0, 0.26)
                }
            }
        }
    }
}
