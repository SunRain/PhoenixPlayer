#ifndef PLAYLISTDELEGATE_H
#define PLAYLISTDELEGATE_H

#include <QObject>

#include "AudioMetaGroupObject.h"
#include "qslistmodel.h"

namespace PhoenixPlayer {
//    namespace MusicLibrary {
//        class MusicLibraryManager;
//    }
    class PlayListMgr;
//    class MusicQueue;
}

class PlayListDelegate : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList availablePlayList READ availablePlayList WRITE setAvailablePlayList NOTIFY availablePlayListChanged)
public:
    explicit PlayListDelegate(QObject *parent = 0);
    virtual ~PlayListDelegate();

    Q_INVOKABLE void refresh();

    ///
    /// \brief addToPlayQueue open listName and add to play queue
    /// \param listName
    ///
    Q_INVOKABLE void addToPlayQueue(const QString &listName);


    QStringList availablePlayList() const;

public slots:
    void setAvailablePlayList(QStringList availablePlayList);

signals:
    void availablePlayListChanged(QStringList availablePlayList);

private:
    PhoenixPlayer::PlayListMgr *m_listMgr;
    QStringList m_availablePlayList;
};

#endif // PLAYLISTDELEGATE_H
