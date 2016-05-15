#ifndef PLAYQUEUEDELEGATE_H
#define PLAYQUEUEDELEGATE_H

#include <QObject>

#include "AudioMetaGroupObject.h"
#include "qslistmodel.h"

namespace PhoenixPlayer {
    namespace MusicLibrary {
        class MusicLibraryManager;
    }
    class PlayListMgr;
    class MusicQueue;
}

class PlayQueueDelegate : public QSListModel
{
    Q_OBJECT

    Q_PROPERTY(int playingIdx READ playingIdx WRITE setPlayingIdx NOTIFY playingIdxChanged)
public:
    explicit PlayQueueDelegate(QObject *parent = 0);
    virtual ~PlayQueueDelegate();

    Q_INVOKABLE void refresh();

    int playingIdx() const;

public slots:
    void setPlayingIdx(int playingIdx);

signals:
    void playingIdxChanged(int playingIdx);

private:
    void sync();
private:
    PhoenixPlayer::MusicQueue *m_playQueue;
    AudioMetaList m_dataList;
    QString m_keyFiled;
    int m_playingIdx;
};

#endif // PLAYQUEUEDELEGATE_H
