#ifndef PLAYLISTDELEGATE_H
#define PLAYLISTDELEGATE_H

#include <QObject>

#include "AudioMetaGroupObject.h"
#include "qslistmodel.h"

namespace PhoenixPlayer {
    namespace MusicLibrary {
        class MusicLibraryManager;
    }
    class PlayListMgr;
}

class PlayListDelegate : public QSListModel
{
    Q_OBJECT
    Q_PROPERTY(QObject* listMgr READ listMgr CONSTANT)
public:
    explicit PlayListDelegate(QObject *parent = 0);
    virtual ~PlayListDelegate();

    Q_INVOKABLE void refresh();

    QObject* listMgr() const;

private:
    void sync();
private:
    PhoenixPlayer::PlayListMgr *m_listMgr;
    AudioMetaList m_dataList;
    QString m_keyFiled;
};

#endif // PLAYLISTDELEGATE_H
