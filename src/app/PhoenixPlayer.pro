include (../PhoenixPlayerCore/libPhoenixPlayer/libPhoenixPlayer.pri)

TEMPLATE = app
QT += qml quick widgets

TARGET = ../PhoenixPlayerCore/libPhoenixPlayer/target/PhoenixPlayer

HEADERS += \
    AudioMetaGroupDelegate.h

SOURCES += \
    main.cpp \
    AudioMetaGroupDelegate.cpp

RESOURCES += \
    ../../qml/qml.qrc \
    ../../images/images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include (../../deployment.pri)
include (../PhoenixPlayerCore/libPhoenixPlayer/include.pri)
include (../../thirdparty/quickflux/quickflux.pri)
include (../../thirdparty/qsyncable/qsyncable.pri)

INCLUDEPATH += \
        $$PWD

isEmpty (LIB_DIR){
    LIB_DIR = /opt/PhoenixPlayer
}

QMAKE_LIBDIR += \
    lib \
    ../PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${OUT_PWD}/../PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${LIB_DIR}/lib

QMAKE_RPATHDIR += \
    lib \
    ../PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${OUT_PWD}/../PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${LIB_DIR}/lib

LIBS += -lPhoenixPlayer

target.path = $$LIB_DIR
INSTALLS += target
