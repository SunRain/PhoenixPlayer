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
//    Q_PROPERTY(QObject* audioMetaListModel READ audioMetaListModel CONSTANT)
    Q_PROPERTY(QVariantList audioMetaList READ audioMetaList NOTIFY audioMetaListChanged)
    Q_PROPERTY(int audioMetaListCount READ audioMetaListCount NOTIFY audioMetaListCountChanged)
    Q_PROPERTY(int audioMetaListTotalTime READ audioMetaListTotalTime NOTIFY audioMetaListTotalTimeChanged)
    Q_PROPERTY(QString keyName READ keyName CONSTANT)
    Q_PROPERTY(QString keyHash READ keyHash CONSTANT)
    Q_PROPERTY(QString keyImgUri READ keyImgUri CONSTANT)
public:
    explicit AudioGroupDelegate(QObject *parent = 0);
    virtual ~AudioGroupDelegate();

//    Q_INVOKABLE void showAllTracks();
    Q_INVOKABLE void showArtistList();
    Q_INVOKABLE void showAlbumList();
    Q_INVOKABLE void showGenresList();
    Q_INVOKABLE void clear();
    ///
    /// \brief showAudioList show AudioMetaList in current group by group hash
    /// \param hash
    ///
    Q_INVOKABLE void showAudioList(const QString &hash);

    QObject* audioMetaListModel() const;

    QString keyName() const;
    QString keyHash() const;
    QString keyImgUri() const;
    QVariantList audioMetaList() const;
    int audioMetaListCount() const;
    int audioMetaListTotalTime() const;

signals:
    void audioMetaListChanged(QVariantList audioMetaList);
    void audioMetaListCountChanged(int audioMetaListCount);
    void audioMetaListTotalTimeChanged(int audioMetaListTotalTime);

private:
    void sync();
    void syncAudioList();

private:
    PhoenixPlayer::MusicLibrary::MusicLibraryManager *m_libraryMgr;
    QSListModel *m_audioMetaListModel;
    AudioMetaGroupList m_dataList;
    AudioMetaList m_audioMetaList;
    QString m_keyFiled;
    int m_audioMetaListCount;
    int m_audioMetaListTotalTime;
};

#endif // AUDIOGROUPDELEGATE_H
