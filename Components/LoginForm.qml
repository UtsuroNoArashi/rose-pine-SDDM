import QtQuick 2.14
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4 as Controls
import QtGraphicalEffects 1.0

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

        color: Qt.rgba(formBGColor.r, formBGColor.g, formBGColor.b, 0.8)
        // FIX 1: removed conflicting `width: parent.width * 0.3`; anchors.fill already covers sizing
        anchors.fill: parent

        layer {
            enabled: true
            effect: FastBlur {
                anchors.fill: formBG
                source: formBG
                radius: 25
            }
        }
    }

    Input {}
}
