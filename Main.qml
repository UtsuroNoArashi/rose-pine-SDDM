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

        Rectangle {
            id: clockBG

            width: parent.width * 0.25
            height: parent.height / 4

            anchors {
                top: parent.top
                left: config.FormPosition == "left" ? undefined : parent.left
                right: config.FormPosition == "right" ? undefined : parent.right
                margins: 50
            }

            opacity: 1
            color: "transparent"

            Clock {}

        }
    }

    MouseArea {
        id: mouseTracker
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
