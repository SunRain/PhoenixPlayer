TEMPLATE = app
QT += qml quick widgets

TARGET = ../PhoenixPlayerCore/libPhoenixPlayer/target/PhoenixPlayer

CONFIG += c++11
CONFIG += WITH_QML_LIB
#CONFIG += USE_QRC

include (../PhoenixPlayerCore/libPhoenixPlayer/libPhoenixPlayer.pri)

HEADERS += \
    AudioGroupDelegate.h \
    ApplicationUtility.h \
    AllMusicDelegate.h \
    PlayListDelegate.h

SOURCES += \
    main.cpp \
    AudioGroupDelegate.cpp \
    ApplicationUtility.cpp \
    AllMusicDelegate.cpp \
    PlayListDelegate.cpp

contains (CONFIG, USE_QRC) {
    RESOURCES += \
        ../../qml/qml.qrc \
        ../../images/images.qrc

    DEFINES += USE_QRC
}


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
