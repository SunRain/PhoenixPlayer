TEMPLATE = subdirs

##################### core lib file
common.file = libPhoenixPlayer.pro
SUBDIRS += common

##################### gstreamer play backend
!win32 {
gstreamer.file = GStreamerBackend.pro
gstreamer.depends = common
SUBDIRS += gstreamer
}

##################### fake play backend
fake.file = FakeBackend.pro
fake.depends = common
SUBDIRS += fake

##################### lookup metadata(lyrics) from baidu server
baidu.file = Baidu.pro
baidu.depends = common
SUBDIRS += baidu

##################### lookup metadata from lastfm server
lastfm.file = LastFM.pro
lastfm.depends = common
SUBDIRS += lastfm

##################### save music library to sqlite3
sqlite3.file = SQLite3.pro
sqlite3.depends = common
SUBDIRS += sqlite3

##################### music tag parser by taglib
tagParserPro.file = TagParserPro.pro
tagParserPro.depends = common
SUBDIRS += tagParserPro
