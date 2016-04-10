#include "AudioGroupDelegate.h"

#include <QDebug>

#include "qslistmodel.h"
#include "qsdiffrunner.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"
#include "AudioMetaObject.h"

#include "MusicLibrary/MusicLibraryManager.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;

AudioGroupDelegate::AudioGroupDelegate(QObject *parent)
    : QSListModel(parent)
    , m_keyFiled(AudioMetaObject::keyHash ())
{
    m_libraryMgr = phoenixPlayerLib->libraryMgr ();
}

AudioGroupDelegate::~AudioGroupDelegate()
{

}

void AudioGroupDelegate::showAllTracks()
{
    m_dataList = m_libraryMgr->allTracks ();
    sync ();
}

void AudioGroupDelegate::sync()
{
    QSDiffRunner runner;
    runner.setKeyField (m_keyFiled);
    QVariantList list;
    foreach (AudioMetaObject o, m_dataList) {
        list.append (o.toObject ().toVariantMap ());
        break;
    }
    QList<QSPatch> patches = runner.compare (this->storage (), list);
    runner.patch (this, patches);
}
