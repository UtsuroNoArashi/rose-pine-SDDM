import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents

Item {
    TextConstants {
        id: textConstants
    }

    Inputs {
        id: inputs
        width: parent.width * 0.75
        anchors.centerIn: parent
    }
}
