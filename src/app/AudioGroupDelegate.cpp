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
    , m_keyFiled(AudioMetaGroupObject::keyName ())
{
    m_libraryMgr = phoenixPlayerLib->libraryMgr ();

    showArtistList ();
}

AudioGroupDelegate::~AudioGroupDelegate()
{

}

void AudioGroupDelegate::showArtistList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";

//    m_dataList.clear ();
    m_dataList = m_libraryMgr->artistList ();
    sync ();
}

void AudioGroupDelegate::showAlbumList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";

//    m_dataList.clear ();
    m_dataList = m_libraryMgr->albumList ();
    sync ();
}

void AudioGroupDelegate::showGenresList()
{
    qDebug()<<">>>>>>>>>>>>>>> "<<Q_FUNC_INFO<<" <<<<<<<<<<<";

//    m_dataList.clear ();
    m_dataList = m_libraryMgr->genreList ();
    sync ();
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
