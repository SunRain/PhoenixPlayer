#include "PlayListDelegate.h"

#include <QDebug>

#include "qslistmodel.h"
#include "qsdiffrunner.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"
#include "AudioMetaObject.h"

#include "PlayerCore/PlayerCore.h"
#include "PlayerCore/PlayListMgr.h"
#include "PlayerCore/MusicQueue.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;

PlayListDelegate::PlayListDelegate(QObject *parent)
    : QSListModel(parent)
    , m_keyFiled(AudioMetaObject::keyHash ())
{
    m_playQueue = phoenixPlayerLib->playerCore ()->playQueue();
    connect (m_playQueue, &MusicQueue::queueChanged,
             [&](){
        m_dataList = m_playQueue->currentList();
//        m_dataList.swap (m_listMgr->currentList ());
        sync ();
    });

    refresh();
}

PlayListDelegate::~PlayListDelegate()
{

}

void PlayListDelegate::refresh()
{
    m_dataList.clear ();
    m_dataList = m_playQueue->currentList();
//    m_dataList.swap (m_listMgr->currentList ());
    sync ();
}

QObject *PlayListDelegate::playQueue() const
{
    return qobject_cast<QObject*>(m_playQueue);
}

void PlayListDelegate::sync()
{
    QSDiffRunner runner;
    runner.setKeyField (m_keyFiled);
    QVariantList list;
    foreach (AudioMetaObject o, m_dataList) {
        list.append (o.toMap ());
    }
    QList<QSPatch> patches = runner.compare (this->storage (), list);
    runner.patch (this, patches);
}
