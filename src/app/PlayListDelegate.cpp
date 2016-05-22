#include "PlayListDelegate.h"

#include <QDebug>

#include "qslistmodel.h"
#include "qsdiffrunner.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"
#include "AudioMetaObject.h"

#include "PluginLoader.h"

#include "PlayerCore/PlayerCore.h"
#include "PlayerCore/PlayListMgr.h"
#include "PlayerCore/MusicQueue.h"

#include "MusicLibrary/IMusicLibraryDAO.h"
#include "MusicLibrary/MusicLibraryDAOHost.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;

PlayListDelegate::PlayListDelegate(QObject *parent)
    : QObject(parent)
{
    m_listMgr = new PlayListMgr(phoenixPlayerLib->settings(), this);

    connect(m_listMgr, &PlayListMgr::existPlayListsChanged,
            [&](const QStringList &list){
        setAvailablePlayList(list);
    });

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

QVariantList PlayListDelegate::openPlaylist(const QString &playlistName) const
{
    QVariantList list;
    foreach (AudioMetaObject o, audioInPlaylist(playlistName)) {
        list.append(o.toMap());
    }
    return list;
}

void PlayListDelegate::createPlaylist(const QString &name, const QJSValue &audioList, bool override)
{
    if (name.isEmpty())
        return;
    if (!audioList.isArray())
        return;
    QVariantList list = audioList.toVariant().toList();
    m_listMgr->clear();
    foreach (QVariant v, list) {
        AudioMetaObject o = AudioMetaObject::fromMap(v.toMap());
        m_listMgr->addTrack(o);
    }
    if (!m_listMgr->save(name, override)) {
        qWarning()<<Q_FUNC_INFO<<"save playlist error";
    }
    m_listMgr->refreshExistPlayLists();
}

void PlayListDelegate::addToPlayQueue(const QString &listName)
{
    foreach (AudioMetaObject o, audioInPlaylist(listName)) {
        phoenixPlayerLib->playerCore()->playQueue()->addTrack(o);
    }
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

AudioMetaList PlayListDelegate::audioInPlaylist(const QString &playlistName) const
{
    if (!m_listMgr->open(playlistName)) {
        qWarning()<<Q_FUNC_INFO<<QString("Open playlist [%1] faile").arg(playlistName);
        return AudioMetaList();
    }
    AudioMetaList list = m_listMgr->currentList();

    MusicLibraryDAOHost *host = phoenixPlayerLib->pluginLoader()->curDAOHost();
    if (host) {
        IMusicLibraryDAO *dao = host->instance<IMusicLibraryDAO>();
        if (dao) {
            AudioMetaList retList;
            foreach (AudioMetaObject o, list) {
                if (dao->trackHashList().contains(o.hash())) {
                    AudioMetaObject obj = dao->trackFromHash(o.hash());
                    retList.append(obj);
                } else {
                    retList.append(o);
                }
            }
            return retList;
        }
    }
    return list;
}




