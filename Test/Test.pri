include (../src/PhoenixPlayerCore/libPhoenixPlayer/libPhoenixPlayer.pri)
include (../src/PhoenixPlayerCore/libPhoenixPlayer/include.pri)

PLUGINS_PREFIX = ../../src/PhoenixPlayerCore/libPhoenixPlayer/target

contains (CONFIG, WITH_QML_LIB) {
    include (../src/PhoenixPlayerCore/libPhoenixPlayer/libPhoenixPlayer/QtQuick/qml.pri)
    QT += quick
}

win32 {
    COPY = copy /y
    MKDIR = mkdir
} else {
    COPY = cp
    MKDIR = mkdir -p
}
