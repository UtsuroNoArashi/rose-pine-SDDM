import QtQuick
import SddmComponents

Item {
    id: formRoot

    TextConstants {
        id: textConstants
    }

    Inputs {
        id: inputs
        width: parent.width * 0.75
        anchors.centerIn: parent
    }
}
