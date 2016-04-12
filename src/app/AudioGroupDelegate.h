#ifndef AUDIOGROUPDELEGATE_H
#define AUDIOGROUPDELEGATE_H

#include <QObject>

#include "AudioMetaGroupObject.h"
#include "qslistmodel.h"

namespace PhoenixPlayer {
    namespace MusicLibrary {
        class MusicLibraryManager;
    }
}
class AudioGroupDelegate : public QSListModel
{
    Q_OBJECT
public:
    explicit AudioGroupDelegate(QObject *parent = 0);
    virtual ~AudioGroupDelegate();

//    Q_INVOKABLE void showAllTracks();
    Q_INVOKABLE void showArtistList();
    Q_INVOKABLE void showAlbumList();
    Q_INVOKABLE void showGenresList();

//signals:
//    void keyFiledChanged(QString keyFiled);

//    void modelChanged(QObject* model);

private:
    void sync();
private:
    PhoenixPlayer::MusicLibrary::MusicLibraryManager *m_libraryMgr;
    AudioMetaGroupList m_dataList;
    QString m_keyFiled;
};

#endif // AUDIOGROUPDELEGATE_H
