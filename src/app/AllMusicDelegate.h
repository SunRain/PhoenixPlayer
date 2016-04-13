#ifndef ALLMUSICDELEGATE_H
#define ALLMUSICDELEGATE_H

#include <QObject>

#include "AudioMetaGroupObject.h"
#include "qslistmodel.h"

namespace PhoenixPlayer {
    namespace MusicLibrary {
        class MusicLibraryManager;
    }
}

class AllMusicDelegate : public QSListModel
{
    Q_OBJECT
public:
    explicit AllMusicDelegate(QObject *parent = 0);
    virtual ~AllMusicDelegate();

    Q_INVOKABLE void refresh();

private:
    void sync();
private:
    PhoenixPlayer::MusicLibrary::MusicLibraryManager *m_libraryMgr;
    AudioMetaList m_dataList;
    QString m_keyFiled;
};

#endif // ALLMUSICDELEGATE_H
