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

//void PlayListDelegate::openPlaylist(const QString &playlistName)
//{
//    if (playlistName.isEmpty())
//        return;
//    if (!m_listMgr->open(playlistName)) {
//        qWarning()<<Q_FUNC_INFO<<QString("Open playlist [%1] faile").arg(playlistName);
//        return;
//    }
////    QVariantList list;
////    foreach (const QVariant v, m_listMgr->currentList()) {
////        list.append(v.toMap());
////    }
////    return list;
//    phoenixPlayerLib->playerCore()->playQueue()->addTrack(m_listMgr->currentList());
//}

void PlayListDelegate::createPlaylist(const QString &name, const QJSValue &audioList)
{
    if (name.isEmpty())
        return;
    if (!audioList.isArray())
        return;
    QVariantList list = audioList.toVariant().toList();
    foreach (QVariant v, list) {
        AudioMetaObject o = AudioMetaObject::fromMap(v.toMap());
        m_listMgr->addTrack(o);
    }
    if (!m_listMgr->save(name)) {
        qWarning()<<Q_FUNC_INFO<<"save playlist error";
    }
    m_listMgr->refreshExistPlayLists();
}

void PlayListDelegate::addToPlayQueue(const QString &listName)
{
    if (!m_listMgr->open(listName)) {
        qWarning()<<Q_FUNC_INFO<<QString("Open playlist [%1] faile").arg(listName);
        return;
    }
    AudioMetaList list = m_listMgr->currentList();

    MusicLibraryDAOHost *host = phoenixPlayerLib->pluginLoader()->curDAOHost();
    if (host) {
        IMusicLibraryDAO *dao = host->instance<IMusicLibraryDAO>();
        if (dao) {
            foreach (AudioMetaObject o, list) {
                if (dao->trackHashList().contains(o.hash())) {
                    AudioMetaObject obj = dao->trackFromHash(o.hash());
                    phoenixPlayerLib->playerCore()->playQueue()->addTrack(obj);

                } else {
                    phoenixPlayerLib->playerCore()->playQueue()->addTrack(o);
                }
            }
            return;
        }
    }
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




