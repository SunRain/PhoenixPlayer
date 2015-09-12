
TEMPLATE = app
QT += qml quick widgets
#Enable c++11
CONFIG += c++11

SOURCES += main.cpp

RESOURCES += ../../qml/qml.qrc \
    ../../images/images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include (../../deployment.pri)
#include (../qml-material/qml-material.pri)
include (../PhoenixPlayerCore/libPhoenixPlayer/Core/CoreHeaders.pri)
include (../PhoenixPlayerCore/libPhoenixPlayer/Plugins/QML/QmlPluginHeaders.pri)


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../PhoenixPlayerCore/release/ -lPhoenixPlayer
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../PhoenixPlayerCore/debug/ -lPhoenixPlayer
else:unix: LIBS += -L$$OUT_PWD/../PhoenixPlayerCore/ -lPhoenixPlayer

INCLUDEPATH += $$PWD/../PhoenixPlayerCore
DEPENDPATH += $$PWD/../PhoenixPlayerCore
