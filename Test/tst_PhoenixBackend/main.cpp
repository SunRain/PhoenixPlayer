#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QtQml>

#include "MusicLibrary/IMusicTagParser.h"
#include "MusicLibrary/MusicLibraryManager.h"
#include "MusicLibrary/LocalMusicScanner.h"
#include "MetadataLookup/MetadataLookupMgrWrapper.h"

#include "PlayerCore/PlayerCore.h"
#include "PlayerCore/PlayListMgr.h"
#include "PlayerCore/VolumeControl.h"

#include "Backend/IPlayBackend.h"
#include "Backend/BackendHost.h"

#include "Settings.h"
#include "PluginLoader.h"
#include "Common.h"
#include "SongMetaData.h"
#include "SingletonPointer.h"
#include "Util.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;
using namespace PhoenixPlayer::MetadataLookup;
using namespace PhoenixPlayer::MetaData;
using namespace PhoenixPlayer::PlayBackend;

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app (new QGuiApplication(argc, argv));
    app.data()->setOrganizationName("SunRain");
    app.data()->setApplicationName("PhoenixPlayer");

    QDir dir(app.data ()->applicationDirPath ());
    app.data ()->addLibraryPath (QString("%1/plugins").arg (dir.absolutePath ()));
    dir.cdUp ();
    app.data ()->addLibraryPath (QString("%1/plugins").arg (dir.absolutePath ()));

//    Settings *settings = Settings::instance ();
    PluginLoader *loader = PluginLoader::instance ();
//    MusicLibraryManager *manager = MusicLibraryManager::instance ();
    VolumeControl *volume = VolumeControl::instance ();
//    volume->setMuted (false);
    volume->setVolume (50);
//    PlayerCore *musicPlayer = PlayerCore::instance ();
//    Util *util = Util::instance ();
//    MetadataLookupMgrWrapper *lookup = MetadataLookupMgrWrapper::instance ();

    BackendHost *h = loader->curBackendHost ();
    IPlayBackend *b = h->instance<IPlayBackend>();
    b->init ();
    b->stop ();
    BaseMediaObject obj;
    obj.setFilePath (app.data ()->applicationDirPath ());
    obj.setFileName ("test.mp3");
    obj.setMediaType (Common::MediaTypeLocalFile);
    b->changeMedia (&obj);
    b->play ();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.data ()->exec ();
}
