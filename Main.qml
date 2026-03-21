import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.15
import "Components"

Rectangle {
    id: root

    width: Screen.width
    height: Screen.height

    color: config.Base

    Image {
        id: wallpaper

        anchors.fill: parent
        source: config.Background

        mirror: !(config.FormPosition == "right")

        ColumnLayout {
            width: parent.width * 0.25
            height: parent.height

            anchors {
                left: config.FormPosition == "left" ? undefined : parent.left
                right: config.FormPosition == "right" ? undefined : parent.right
                top: parent.top 
                bottom: parent.bottom 

                margins: 100
            }

            Clock {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            SystemButtonTray {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }
        }
    }

    // MouseArea {
    //     id: mouseTracker
    //     anchors.fill: parent
    //     hoverEnabled: true
    //     acceptedButtons: Qt.NoButton
    // }
}
