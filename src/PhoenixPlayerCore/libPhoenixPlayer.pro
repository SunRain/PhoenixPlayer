TEMPLATE = lib

TARGET = PhoenixPlayer

QT += network core quick

#Enable c++11
CONFIG += c++11


include (libPhoenixPlayer/Core/Core.pri)
include (libPhoenixPlayer/Plugins/QML/qml.pri)


