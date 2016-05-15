#include "PlayQueueDelegate.h"

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

PlayQueueDelegate::PlayQueueDelegate(QObject *parent)
    : QSListModel(parent)
    , m_keyFiled(AudioMetaObject::keyHash ())
    , m_playingIdx(-1)
{
    m_playQueue = phoenixPlayerLib->playerCore ()->playQueue();
    connect (m_playQueue, &MusicQueue::queueChanged,
             [&](){
        m_dataList = m_playQueue->currentList();
        sync ();
    });
    connect(m_playQueue, &MusicQueue::currentIndexChanged,
            [&](int idx) {
        setPlayingIdx(idx);
    });

    refresh();
}

PlayQueueDelegate::~PlayQueueDelegate()
{

}

void PlayQueueDelegate::refresh()
{
    m_dataList.clear ();
    m_dataList = m_playQueue->currentList();
    sync ();
}

int PlayQueueDelegate::playingIdx() const
{
    return m_playingIdx;
}

void PlayQueueDelegate::setPlayingIdx(int playingIdx)
{
    if (m_playingIdx == playingIdx)
        return;

    m_playingIdx = playingIdx;
    emit playingIdxChanged(playingIdx);
}

void PlayQueueDelegate::sync()
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
