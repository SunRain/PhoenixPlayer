#include <QApplication>
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QQuickView>
#include <QQmlContext>
#include <QtQml>

#include "MusicLibrary/IMusicTagParser.h"
#include "MusicLibrary/MusicLibraryManager.h"
#include "MusicLibrary/LocalMusicScanner.h"
#include "MetadataLookup/MetadataLookupMgrWrapper.h"

#include "PlayerCore/PlayerCore.h"
#include "PlayerCore/PlayListMgr.h"
#include "PlayerCore/VolumeControl.h"

#include "Settings.h"
#include "PluginLoader.h"
#include "Common.h"
#include "AudioMetaObject.h"
#include "SingletonPointer.h"
#include "Utility.h"

#include "LyricsModel.h"
#include "MusicLibraryListModel.h"
#include "CircleImage.h"
#include "CoverCircleImage.h"
#include "TrackGroupModel.h"
#include "AddonListModel.h"
#include "PluginListModel.h"
#include "AudioMetaObjectKeys.h"

#include "libphoenixplayer_global.h"
#include "LibPhoenixPlayerMain.h"

#include "AudioGroupDelegate.h"

#include "ApplicationUtility.h"

using namespace PhoenixPlayer;
using namespace PhoenixPlayer::MusicLibrary;
using namespace PhoenixPlayer::QmlPlugin;
using namespace PhoenixPlayer::MetadataLookup;
//using namespace PhoenixPlayer::MetaData;

int main(int argc, char *argv[])
{

    QScopedPointer<QGuiApplication> app (new QGuiApplication(argc, argv));
    app.data()->setOrganizationName("SunRain");
    app.data()->setApplicationName("PhoenixPlayer");

    // 设置系统插件目录
    QDir dir(app.data ()->applicationDirPath ());
    app.data ()->addLibraryPath (QString("%1/plugins").arg (dir.absolutePath ()));
    dir.cdUp ();
    app.data ()->addLibraryPath (QString("%1/plugins").arg (dir.absolutePath ()));

    qDebug()<<" system library path is "<<app.data ()->libraryPaths ();

    // 装载系统翻译文件
    QString lang = QLocale::system ().name ();
    qDebug()<<" system lang is "<<lang;
    QString langFile = QString("%1/translations/PhoenixPlayer-%2.qm").arg (dir.absolutePath ()).arg (lang);
    QTranslator translator;
    if (!QFile::exists (langFile)) {
        langFile = QString("%1/translations/PhoenixPlayer.qm").arg (dir.absolutePath ());
    }
    qDebug()<<" try load translator file "<<langFile;
    translator.load (langFile);
    app.data ()->installTranslator (&translator);


    // 装载插件翻译文件
    //TODO: 暂时装载所有翻译
    foreach (QString path, Utility::getAddonDirList ()) {
        QDir dir(path);
        QStringList aList = dir.entryList (QDir::Dirs);
        foreach (QString addonDir, aList) {
            langFile = QString("%1/%2/lng-%3.qm").arg (path).arg (addonDir).arg (lang);
            if (QFile::exists (langFile)) {
                qDebug()<<" try load addon translator file "<<langFile;
                QTranslator *t = new QTranslator(app.data ());
                t->load (langFile);
                app.data ()->installTranslator (t);
            }
        }
    }

    PhoenixPlayer::LibPhoenixPlayer_Init ();
    LibPhoenixPlayer::instance ()->registerPlugins ("com.sunrain.phoenixplayer.qmlplugin");

    /////////////////////////////////////////////////
//    qmlRegisterUncreatableType<Common>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "Common", "Cannot be created");
    qmlRegisterType<LyricsModel>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "LyricsModel");
//    qmlRegisterType<MusicLibraryListModel>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "MusicLibraryListModel");
    qmlRegisterType<CircleImage>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "CircleImage");
    qmlRegisterType<CoverCircleImage>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "CoverCircleImage");
    qmlRegisterType<TrackGroupModel>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "TrackGroupModel");
//    qmlRegisterType<PathListModel>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "PathListModel");
    qmlRegisterType<AddonListModel>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "AddonListModel");
//    qmlRegisterType<LocalMusicScanner>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "LocalMusicScanner");
    qmlRegisterType<PluginListModel>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "PluginListModel");
    qmlRegisterType<AudioGroupDelegate>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "AudioGroupDelegate");
    qmlRegisterUncreatableType<AudioMetaObjectKeyName>("com.sunrain.phoenixplayer.qmlplugin", 1, 0, "AudioMetaObjectKeyName", "Cannot be created");

    QScopedPointer<ApplicationUtility> appUtility(new ApplicationUtility());
    QScopedPointer<QQmlApplicationEngine> engine(new QQmlApplicationEngine(app.data ()));
    QQmlContext *ctx = engine.data ()->rootContext ();
    ctx->setContextProperty ("util", Utility::instance ());
    ctx->setContextProperty ("AppUtility", appUtility.data ());
//    ctx->setContextProperty ("groupDelegate", d);
    engine.data ()->load (QUrl(QStringLiteral("qrc:/main.qml")));
    return app.data()->exec();
}
