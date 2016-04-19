#include "ApplicationUtility.h"

#include <QDebug>
#include <QVariant>

#include "AudioMetaGroupObject.h"
#include "AudioMetaObject.h"

using namespace PhoenixPlayer;
ApplicationUtility::ApplicationUtility(QObject *parent)
    : QObject(parent)
{

}

QJSValue ApplicationUtility::groupObjectToName(const QJSValue &data)
{
    if (!data.isObject ())
        return QJSValue();
    return data.property (AudioMetaGroupObject::keyName ());
}

QJSValue ApplicationUtility::groupObjectToImgUri(const QJSValue &data)
{
    if (!data.isObject ())
        return QJSValue();

    QJSValue v = data.property (AudioMetaGroupObject::keyImgUri ());
//    qDebug()<<Q_FUNC_INFO<<" image value "<<v.toVariant ();
    return v;
}

QJSValue ApplicationUtility::groupObjectToList(const QJSValue &data)
{
//    qDebug()<<Q_FUNC_INFO<<"key ["<<key<<"] data ["<<data<<"]";
//    qDebug()<<Q_FUNC_INFO<<"jsvalue arrary "<<data.isArray ()<<" string "<<data.isString ()
//           <<" obj "<<data.isObject ()<<" variant "<<data.isVariant ();

    return data;
}

QJSValue ApplicationUtility::groupObjectToHash(const QJSValue &data)
{
    if (!data.isObject ())
        return QJSValue();
    QJSValue v = data.property (AudioMetaGroupObject::keyHash ());
//    qDebug()<<Q_FUNC_INFO<<"hash value "<<v.toVariant ();
    return v;
}

QUrl ApplicationUtility::qrcStrPath(const QString &localPath)
{
    if (localPath.isEmpty ())
        return QUrl();
#ifdef USE_QRC
    if (localPath.startsWith ("/"))
        return QUrl::fromLocalFile (localPath);
#endif
    return localPath;
}

QJSValue ApplicationUtility::randomFromPalette(const QJSValue &palette)
{
    if (palette.isNull () || palette.isUndefined ())
        return QJSValue();
    if (!palette.isObject ())
        return QJSValue();
    QVariantMap map = palette.toVariant ().toMap ();
    if (map.isEmpty ())
        return QJSValue();

    // first layer
    QStringList keys = map.keys ();
    if (keys.isEmpty ())
        return QJSValue();

    QTime t = QTime::currentTime ();
    qsrand (t.msec () + t.second () * 200);

    int pos = qrand () % keys.size ();
    QString key = keys.at (pos);
    QVariant v = map.value (key);

    // 2nd layer
    map.clear ();
    keys.clear ();

    map = v.toMap ();
    keys = map.keys ();
    if (keys.isEmpty ())
        return QJSValue(v.toString ());

    pos = qrand () % keys.size ();
    key = keys.at (pos);
    v = map.value (key);
    return QJSValue(v.toString ());
}

QJSValue ApplicationUtility::pareseAudioMetaObject(const QString &key, const QJSValue &data)
{
    qDebug()<<Q_FUNC_INFO<<"==============================";

    qDebug()<<Q_FUNC_INFO<<"key value "<<key;

        qDebug()<<Q_FUNC_INFO<<"jsvalue arrary "<<data.isArray ()<<" string "<<data.isString ()
               <<" obj "<<data.isObject ()<<" variant "<<data.isVariant ();

        if (!data.isObject ())
            return QJSValue();

        QJSValue v = data.property (key);

        qDebug()<<Q_FUNC_INFO<<"v value "<<v.isArray ()<<" string "<<v.isString ()
               <<" obj "<<v.isObject ()<<" variant "<<v.isVariant ();

        if (v.isString ()) {
            qDebug()<<"value is string "<<v.toString ();
        }

        return v;
}









