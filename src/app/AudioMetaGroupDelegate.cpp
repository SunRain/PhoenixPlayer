#include "AudioMetaGroupDelegate.h"

#include <QDebug>

#include "qslistmodel.h"
#include "qsdiffrunner.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"
#include "AudioMetaObject.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;

AudioMetaGroupDelegate::AudioMetaGroupDelegate(QObject *parent)
    : QObject(parent)
{
    m_libraryMgr = phoenixPlayerLib->libraryMgr ();
    m_listStore = new QSListModel(this);
    sync ();
}

AudioMetaGroupDelegate::~AudioMetaGroupDelegate()
{

}

void AudioMetaGroupDelegate::showAllTracks()
{

}

void AudioMetaGroupDelegate::sync()
{
    QSDiffRunner runner;
    runner.setKeyField (AudioMetaObject::keyHash ());
    QVariantList list;
    foreach (AudioMetaObject o, m_dataList) {
        list.append (QVariant(o.toObject ()));
    }
    QList<QSPatch> patches = runner.compare (m_listStore->storage (), list);
    runner.patch (m_listStore, patches);
}
