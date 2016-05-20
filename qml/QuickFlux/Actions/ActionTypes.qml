pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

KeyTable {
    id: actionTypes

    property string selectMusicScannerDirs
    property string showProgress
    property string hideProgress
    property string localMusicScannerFinish

    property string showAlbumCategory
    property string showArtistCategory
    property string showGenresCategory
    property string showAllMusic

    property string adaptCtrlBarCover
    property string changeCtrlBarCover

    property string adaptCtrlBarTitle
    property string changeCtrlBarTitle

    property string adaptCtrlBarAlbumName
    property string changeCtrlBarAlbumName

    property string adaptCtrlBarArtistName
    property string changeCtrlBarArtistName

    property string adaptSkipBackward
    property string doSkipBackward

    property string adaptSkipForward
    property string doSkipForward

    property string changePlayMode

    property string openPlstCreateDlg
    property string playPlst
    property string savePlst
    property string openPlstModifyDlg
}
