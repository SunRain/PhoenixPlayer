import QtQuick 2.4
import Material 0.2

QObject {
    id: randomColor;

    property string primaryColor: "#FAFAFA"
    property string primaryDarkColor: Qt.rgba(0,0,0, 0.54)
    property string primaryLightColor: Qt.rgba(0,0,0, 0.70)

    property string accentColor: "#2196F3"
//    property color backgroundColor: "#f3f3f3"
//    property color highlightColor: accentColor

    property string textColor: "FFFFFF"
    property string subTextColor: "727272"
//    property color iconColor: inner.light ? subTextColor : textColor
//    property color hintColor: inner.light ? shade(0.26) : shade(0.30)
//    property color dividerColor: inner.shade(0.12)

    function generate() {
        var idx = Math.floor(Math.random()*10) % inner.colorPalette.length;
        primaryColor = inner.getColor(inner.colorPalette[idx], "500");
        primaryDarkColor = inner.getColor(inner.colorPalette[idx], "700");
        primaryLightColor = inner.getColor(inner.colorPalette[idx], "100");

        inner.light = inner.isDarkColor(primaryColor);

        idx = Math.floor(Math.random()*10) % inner.colorPalette.length;
        accentColor = inner.getColor(inner.colorPalette[idx], "A200");
//        backgroundColor = inner.getColor(inner.colorPalette[idx], "A200")
    }

    QtObject {
        id: inner

        property bool light: true
        onLightChanged: {
            textColor = light ? shade(0.7) : shade(1);
            subTextColor = light ? shade(0.54) : shade(0.70);

        }

        //from Palette.colors in material lib
        property var colorPalette: [
            "red", "pink", "purple", "deepPurple", "indigo",
            "blue", "lightBlue", "cyan", "teal", "green",
            "lightGreen", "lime", "yellow", "amber", "orange",
            "deepOrange", "grey", "blueGrey", "brown"
        ]


        function getColor(color, shade) {
            if (Palette.colors.hasOwnProperty(color)) {
                return Palette.colors[color][shade]
            } else {
                return color
            }
        }

//        function alpha(color, alpha) {
//            // Make sure we have a real color object to work with (versus a string like "#ccc")
//            var realColor = Qt.darker(color, 1)

//            realColor.a = alpha

//            return realColor
//        }

//        function lightDark(background, lightColor, darkColor) {
//            return isDarkColor(background) ? darkColor : lightColor
//        }

        function isDarkColor(background) {
            var temp = Qt.darker(background, 1)

            var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);

            return temp.a > 0 && a >= 0.3
        }

        function shade(alpha) {
            if (light) {
                return Qt.rgba(0,0,0,alpha)
            } else {
                return Qt.rgba(1,1,1,alpha)
            }
        }

    }
}
