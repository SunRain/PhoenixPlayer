#include "AudioGroupDelegate.h"

#include <QDebug>

#include "qslistmodel.h"
#include "qsdiffrunner.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"
#include "AudioMetaObject.h"
#include "AudioMetaGroupObject.h"

#include "MusicLibrary/MusicLibraryManager.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;

AudioGroupDelegate::AudioGroupDelegate(QObject *parent)
    : QSListModel(parent)
    , m_keyFiled(AudioMetaGroupObject::keyHash ())
{
    m_libraryMgr = phoenixPlayerLib->libraryMgr ();
    m_audioMetaListModel = new QSListModel(this);
    clear ();
}

AudioGroupDelegate::~AudioGroupDelegate()
{

}

void AudioGroupDelegate::showArtistList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";
m_dataList.clear ();
sync ();
    m_dataList = m_libraryMgr->artistList ();
//    foreach (AudioMetaGroupObject o, m_dataList) {
//        qDebug()<<Q_FUNC_INFO<<"== hash "<<o.hash ();

//    }
    sync ();
}

void AudioGroupDelegate::showAlbumList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";
m_dataList.clear ();
sync ();
    m_dataList = m_libraryMgr->albumList ();
//    foreach (AudioMetaGroupObject o, m_dataList) {
//        qDebug()<<Q_FUNC_INFO<<"== hash "<<o.hash ();

//    }
    sync ();
}

void AudioGroupDelegate::showGenresList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";

    m_dataList.clear ();
    sync ();
    m_dataList = m_libraryMgr->genreList ();
//    foreach (AudioMetaGroupObject o, m_dataList) {
//        qDebug()<<Q_FUNC_INFO<<"== hash "<<o.hash ();

//    }
    sync ();
}

void AudioGroupDelegate::clear()
{
    m_dataList.clear ();
    m_audioMetaList.clear ();
    syncAudioList ();
    sync ();
}

void AudioGroupDelegate::showAudioList(const QString &hash)
{
    qDebug()<<"=========== "<<Q_FUNC_INFO<<" ==========";
    qDebug()<<Q_FUNC_INFO<<"hash is "<<hash;
    m_audioMetaList.clear ();
    syncAudioList ();
    if (hash.isEmpty ())
        return;
    foreach (AudioMetaGroupObject o, m_dataList) {
//        qDebug()<<"loop for object "<<o.hash ();
        if (o.hash () == hash) {
            qDebug()<<">> match for hash "<<o.hash ();
            m_audioMetaList = o.list ();
            qDebug()<<">> match for list size "<<o.list ().size ();
            qDebug()<<">> match for m_audioMetaList list size "<<m_audioMetaList.size ();
            break;
        }
    }
    syncAudioList ();
//    emit audioMetaListChanged (m_audioMetaList);
}

QObject *AudioGroupDelegate::audioMetaListModel() const
{
    return m_audioMetaListModel;
}

QString AudioGroupDelegate::keyName() const
{
    return AudioMetaGroupObject::keyName ();
}

QString AudioGroupDelegate::keyHash() const
{
    return AudioMetaGroupObject::keyHash ();
}

QString AudioGroupDelegate::keyImgUri() const
{
    return AudioMetaGroupObject::keyImgUri ();
}

QVariantList AudioGroupDelegate::audioMetaList() const
{
    QVariantList list;
    foreach (AudioMetaObject o, m_audioMetaList) {
        list.append (o.toMap ());
    }
    return list;
}

void AudioGroupDelegate::sync()
{
    QSDiffRunner runner;
    runner.setKeyField (m_keyFiled);
    QVariantList list;
    foreach (AudioMetaGroupObject o, m_dataList) {
        list.append (o.toMap ());
    }
    QList<QSPatch> patches = runner.compare (this->storage (), list);
    runner.patch (this, patches);

    qDebug()<<Q_FUNC_INFO<<"Data size "<<this->storage ().size ();
}

void AudioGroupDelegate::syncAudioList()
{
    QSDiffRunner runner;
    runner.setKeyField (AudioMetaObject::keyHash ());
    QVariantList list;
    foreach (AudioMetaObject o, m_audioMetaList) {
        list.append (o.toMap ());
    }
    QList<QSPatch> patches = runner.compare (m_audioMetaListModel->storage (), list);
    runner.patch (m_audioMetaListModel, patches);

    qDebug()<<Q_FUNC_INFO<<"m_audioMetaListModel Data size "<<m_audioMetaListModel->storage ().size ();

     emit audioMetaListChanged (list);
}





