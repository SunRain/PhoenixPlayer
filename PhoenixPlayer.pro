TEMPLATE = subdirs
CONFIG += ordered

PhoenixPlayerCore.file = src/PhoenixPlayerCore/libPhoenixPlayer/libPhoenixPlayer.pro
SUBDIRS += PhoenixPlayerCore

app.file = src/app/PhoenixPlayer.pro
app.depends = PhoenixPlayerCore
SUBDIRS += app

SUBDIRS += \
        Test/tst_PhoenixBackend
#qml-material.file = src/qml-material/qml-material.pro
#SUBDIRS += qml-material
