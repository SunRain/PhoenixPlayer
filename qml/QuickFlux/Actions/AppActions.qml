pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    signal showProgress();
    signal hideProgress();
    signal selectMusicScannerDirs();

//    signal toMusicCategoryPage();
//    signal toAllMusicPage();

    signal showAlbumCategory();
    signal showArtistCategory();
    signal showGenresCategory();
    signal showAllMusic();

    function togglePlayPause() {
        Player.togglePlayPause();
    }
}
