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
    : QObject(parent)
{
    m_listMgr = phoenixPlayerLib->playerCore()->listMgr();
    refresh();
}

PlayListDelegate::~PlayListDelegate()
{

}

void PlayListDelegate::refresh()
{
    QStringList list = m_listMgr->existPlayLists();
    setAvailablePlayList(list);
}

void PlayListDelegate::addToPlayQueue(const QString &listName)
{
    if (!m_listMgr->open(listName))
        return;
    AudioMetaList list = m_listMgr->currentList();
    phoenixPlayerLib->playerCore()->playQueue()->addTrack(list);
}

QStringList PlayListDelegate::availablePlayList() const
{
    return m_availablePlayList;
}

void PlayListDelegate::setAvailablePlayList(QStringList availablePlayList)
{
    if (m_availablePlayList == availablePlayList)
        return;
    m_availablePlayList = availablePlayList;
    emit availablePlayListChanged(availablePlayList);
}




