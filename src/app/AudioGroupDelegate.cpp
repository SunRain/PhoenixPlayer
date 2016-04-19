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

    m_dataList = m_libraryMgr->artistList ();
    sync ();
}

void AudioGroupDelegate::showAlbumList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";

    m_dataList = m_libraryMgr->albumList ();
    sync ();
}

void AudioGroupDelegate::showGenresList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";

    m_dataList = m_libraryMgr->genreList ();
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
}

QObject *AudioGroupDelegate::audioMetaListModel() const
{
    return m_audioMetaListModel;
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
}





