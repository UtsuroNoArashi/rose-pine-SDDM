import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Components"


Item {
    id: root 

    width: Screen.width
    height: Screen.height

     Background {
         color: config.color 
         source: Qt.resolvedUrl("./Backgrounds/Wallpaper.jpg")
     }
}
