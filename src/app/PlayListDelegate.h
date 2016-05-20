#ifndef PLAYLISTDELEGATE_H
#define PLAYLISTDELEGATE_H

#include <QObject>
#include <QJSValue>

#include "AudioMetaGroupObject.h"
#include "qslistmodel.h"

namespace PhoenixPlayer {
    class PlayListMgr;
}

class PlayListDelegate : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList availablePlayList READ availablePlayList WRITE setAvailablePlayList NOTIFY availablePlayListChanged)
public:
    explicit PlayListDelegate(QObject *parent = 0);
    virtual ~PlayListDelegate();

    ///
    /// \brief refresh refresh available Playlist
    ///
    Q_INVOKABLE void refresh();


    ///
    /// \brief openPlaylist
    /// \param playlistName
    ///
//    Q_INVOKABLE void openPlaylist(const QString &playlistName);


    ///
    /// \brief createPlaylist
    /// \param name playlist name
    /// \param audioList
    ///
    Q_INVOKABLE void createPlaylist(const QString &name, const QJSValue &audioList);

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
