pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

KeyTable {
    id: actionTypes

    property string selectMusicScannerDirs
    property string showProgress
    property string hideProgress

//    property string toMusicCategoryPage
//    property string toAllMusicPage

    property string showAlbumCategory
    property string showArtistCategory
    property string showGenresCategory
    property string showAllMusic
}
