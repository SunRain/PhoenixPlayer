#ifndef AUDIOMETAGROUPDELEGATE_H
#define AUDIOMETAGROUPDELEGATE_H

#include <QObject>

#include "AudioMetaObject.h"

namespace PhoenixPlayer {
    namespace MusicLibrary {
        class MusicLibraryManager;
    }
}
class QSListModel;
class AudioMetaGroupDelegate : public QObject
{
    Q_OBJECT
public:
    explicit AudioMetaGroupDelegate(QObject *parent = 0);
    virtual ~AudioMetaGroupDelegate();

    Q_INVOKABLE void showAllTracks();

private:
    void sync();
private:
    PhoenixPlayer::MusicLibrary::MusicLibraryManager *m_libraryMgr;
    QSListModel *m_listStore;
    AudioMetaList m_dataList;
};

#endif // AUDIOMETAGROUPDELEGATE_H
