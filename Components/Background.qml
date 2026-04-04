import QtQuick

Rectangle {
    id: rootBG 

    property alias color: rootBG.color
    property alias source: wallpaper.source
    property alias mirror: wallpaper.mirror

    anchors.fill: parent
    color: color

    Image {
        id: wallpaper
        anchors.fill: parent 
        source: source
        fillMode: Image.PreserveAspectCrop

        mirror: mirror
    }
}
