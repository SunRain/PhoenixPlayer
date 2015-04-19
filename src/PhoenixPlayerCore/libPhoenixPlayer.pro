TEMPLATE = lib

TARGET = PhoenixPlayer

QT += network core quick

#Enable c++11
CONFIG += c++11


include (PhoenixPlayerCore/Core/Core.pri)
include (PhoenixPlayerCore/Plugins/QML/qml.pri)


