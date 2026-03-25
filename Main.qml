import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.0
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

        LoginForm {}

        ColumnLayout {
            width: parent.width * 0.3 
            height: parent.height * 0.9

            anchors {
                left: config.FormPosition == "left" ? undefined : parent.left
                right: config.FormPosition == "right" ? undefined : parent.right
                verticalCenter: parent.verticalCenter
            }

            Clock {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            SystemButtonTray {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }
        }
    }
}
