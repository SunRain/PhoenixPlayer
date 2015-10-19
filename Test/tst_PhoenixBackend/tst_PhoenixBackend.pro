include (../../src/PhoenixPlayerCore/libPhoenixPlayer/libPhoenixPlayer.pri)
include (../Test.pri)

TEMPLATE = app

QT += qml quick widgets

TARGET = ../../src/PhoenixPlayerCore/libPhoenixPlayer/target/tst_PhoenixBackend


SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include (../../deployment.pri)
include (../../src/PhoenixPlayerCore/libPhoenixPlayer/include.pri)

INCLUDEPATH += \
        $$PWD

isEmpty (LIB_DIR){
    LIB_DIR = /opt/PhoenixPlayer
}

QMAKE_LIBDIR += \
    lib \
    ../../src/PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${OUT_PWD}/../../src/PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${LIB_DIR}/lib

QMAKE_RPATHDIR += \
    lib \
    ../../src/PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${OUT_PWD}/../../src/PhoenixPlayerCore/libPhoenixPlayer/target/lib \
    $${LIB_DIR}/lib

LIBS += -lPhoenixPlayer

target.path = $$LIB_DIR
INSTALLS += target

OTHER_FILES += \
    test.mp3

!equals($${_PRO_FILE_PWD_}, $${OUT_PWD}) {
    for(f, OTHER_FILES){
        #TODO need windows basename cmd
        unix:base_name = $$basename(f)
        dist = $${OUT_PWD}/$${PLUGINS_PREFIX}
        dist_file = $${OUT_PWD}/$${PLUGINS_PREFIX}/$${base_name}
        !exists($$dist):system($$MKDIR $$dist)
        !exists($$dist_file):system($$COPY $$f $$dist_file)
    }
}
