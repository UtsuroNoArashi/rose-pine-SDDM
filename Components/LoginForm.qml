import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls as Controls
import Qt5Compat.GraphicalEffects

Item {
    id: formRoot
    width: parent.width * 0.3
    height: parent.height

    anchors {
        verticalCenter: parent.verticalCenter
        left: config.FormPosition == "left" ? parent.left : undefined
        right: config.FormPosition == "right" ? parent.right : undefined
    }

    Rectangle {
        id: formBG

        property color formBGColor: config.Base

        color: Qt.rgba(formBGColor.r, formBGColor.g, formBGColor.b, 0.6)
        anchors.fill: parent
    }

    Input {
        anchors.centerIn: parent
        width: parent.width * 0.75
        height: parent.height
    }
}
