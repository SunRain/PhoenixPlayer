#ifndef APPLICATIONUTILITY_H
#define APPLICATIONUTILITY_H

#include <QObject>
#include <QJSValue>
#include <QUrl>

#include "SingletonPointer.h"

class ApplicationUtility : public QObject
{
    Q_OBJECT

//    DECLARE_SINGLETON_POINTER(ApplicationUtility)
public:
    explicit ApplicationUtility(QObject *parent = 0);

    ///
    /// \brief groupObjectToName  parse AudioMetaGroupObject
    /// \param data
    /// \return AudioMetaGroupObject->name;
    ///
    Q_INVOKABLE QJSValue groupObjectToName(const QJSValue &data);

    ///
    /// \brief groupObjectToImgUri parse AudioMetaGroupObject
    /// \param data
    /// \return AudioMetaGroupObject->imageUri
    ///
    Q_INVOKABLE QJSValue groupObjectToImgUri(const QJSValue &data);

    ///
    /// \brief groupObjectToList parse AudioMetaGroupObject
    /// \param data
    /// \return AudioMetaGroupObject->AudioMetaList;
    ///
    Q_INVOKABLE QJSValue groupObjectToList(const QJSValue &data);

    ///
    /// \brief qrcStrPath convert local path to qrc.
    /// eg. /path/to/file ==> file:///path/to/file
    /// \param localPath
    /// \return
    ///
    Q_INVOKABLE QUrl qrcStrPath(const QString &localPath);

    ///
    /// \brief randomFromPalette a random color string from Palette in qml-material library
    /// \param palette
    /// \return
    ///
    Q_INVOKABLE QJSValue randomFromPalette(const QJSValue &palette);

    ///
    /// \brief pareseAudioMetaObject
    /// \param key key for data
    /// \param data the object
    /// \return value of key
    ///
    Q_INVOKABLE QJSValue pareseAudioMetaObject(const QString &key, const QJSValue &data);


};

#endif // APPLICATIONUTILITY_H
