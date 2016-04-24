#include "PlayListDelegate.h"

#include <QDebug>

#include "qslistmodel.h"
#include "qsdiffrunner.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"
#include "AudioMetaObject.h"

#include "PlayerCore/PlayerCore.h"
#include "PlayerCore/PlayListMgr.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;

PlayListDelegate::PlayListDelegate(QObject *parent)
    : QSListModel(parent)
    , m_keyFiled(AudioMetaObject::keyHash ())
{
    m_listMgr = phoenixPlayerLib->playerCore ()->playList ();
    connect (m_listMgr, &PlayListMgr::queueChanged,
             [&](){
        m_dataList = m_listMgr->currentList ();
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
    m_dataList = m_listMgr->currentList ();
//    m_dataList.swap (m_listMgr->currentList ());
    sync ();
}

QObject *PlayListDelegate::listMgr() const
{
    return qobject_cast<QObject*>(m_listMgr);
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
