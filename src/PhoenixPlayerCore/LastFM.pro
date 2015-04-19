TEMPLATE = lib
CONFIG += plugin

QT += network

TARGET = LastFmMetaDataLookup

#Enable c++11
CONFIG += c++11

#TODO 暂时链接库文件
#include(PhoenixPlayerCore/Core/Core.pri)
include (PhoenixPlayerCore/Core/CoreHeaders.pri)

include (PhoenixPlayerCore/Plugins/MetadataLookup/LastFM/LastFM.pri)

INCLUDEPATH += \
        $$PWD

#DESTDIR = ../../../plugins



win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/release/ -lPhoenixPlayer
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/debug/ -lPhoenixPlayer
else:unix: LIBS += -L$$OUT_PWD/ -lPhoenixPlayer

INCLUDEPATH += $$PWD/
DEPENDPATH += $$PWD/
