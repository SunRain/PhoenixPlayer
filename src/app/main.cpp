#include <QApplication>
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QQuickView>
#include <QQmlContext>
#include <QtQml>

#include "MusicLibrary/IMusicTagParser.h"
#include "MusicLibrary/MusicLibraryManager.h"

#include "Player/Player.h"

#include "Settings.h"
#include "PluginLoader.h"
#include "Common.h"
#include "SongMetaData.h"
#include "SingletonPointer.h"
#include "Util.h"

#include "LyricsModel.h"
#include "MusicLibraryListModel.h"
#include "CircleImage.h"
#include "CoverCircleImage.h"
#include "TrackGroupModel.h"
#include "PathListModel.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;
using namespace PhoenixPlayer::QmlPlugin;

int main(int argc, char *argv[])
{
//    QApplication app(argc, argv);

////    QQmlApplicationEngine engine;
////    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    return app.exec();

    QScopedPointer<QGuiApplication> app (new QGuiApplication(argc, argv));
    app.data()->setOrganizationName("SunRain");
    app.data()->setApplicationName("PhoenixPlayer");

    Settings *settings = SingletonPointer<Settings>::instance ();

    qmlRegisterUncreatableType<Common>("sunrain.phoenixplayer.qmlplugin", 1, 0, "Common", "");
    qmlRegisterType<LyricsModel>("sunrain.phoenixplayer.qmlplugin", 1, 0, "LyricsModel");
    qmlRegisterType<MusicLibraryListModel>("sunrain.phoenixplayer.qmlplugin", 1, 0, "MusicLibraryListModel");
    qmlRegisterType<CircleImage>("sunrain.phoenixplayer.qmlplugin", 1, 0, "CircleImage");
    qmlRegisterType<CoverCircleImage>("sunrain.phoenixplayer.qmlplugin", 1, 0, "CoverCircleImage");
    qmlRegisterType<TrackGroupModel>("sunrain.phoenixplayer.qmlplugin", 1, 0, "TrackGroupModel");
    qmlRegisterType<PathListModel>("sunrain.phoenixplayer.qmlplugin", 1, 0, "PathListModel");

//    QString dir = SailfishApp::pathTo(QString("lib")).toLocalFile();

//    PluginLoader *loader = PluginLoader::instance();
//    loader->setPluginPath(PluginLoader::TypeAll, dir);
//    loader->setNewPlugin (PluginLoader::TypePlayBackend, "GStreamerBackend");

    MusicLibraryManager *manager = SingletonPointer<MusicLibraryManager>::instance ();
    Player *musicPlayer = SingletonPointer<Player>::instance ();
    Util *util = SingletonPointer<Util>::instance ();

    QScopedPointer<QQmlApplicationEngine> engine(new QQmlApplicationEngine(app.data ()));
    QQmlContext *ctx = engine.data ()->rootContext ();

    ctx->setContextProperty ("musicLibraryManager", manager);
    ctx->setContextProperty ("musicPlayer", musicPlayer);
    ctx->setContextProperty ("settings", settings);
    ctx->setContextProperty ("util", util);

    engine.data ()->load (QUrl(QStringLiteral("qrc:/main.qml")));
    return app.data()->exec();
}
