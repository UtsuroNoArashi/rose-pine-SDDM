import QtQuick
import QtQuick.Controls 
import QtQuick.Layouts 
import SddmComponents

Column {

    readonly property color fieldsBGSolid: theme.current.surface
    readonly property color fieldsBGAlpha: Qt.rgba(fieldsBGSolid.r, fieldsBGSolid.g, fieldsBGSolid.b, 0.4)

    // TODO: complete fiels customization; add combo boxes for session, user, keyboard layout
    spacing: 10

    TextField {
        id: userField
        width: parent.width * 0.5 
        height: root.fontSize * 4.5

        anchors {
            left: root.formIsLeft ? parent.left : undefined 
            right: root.formIsLeft ? undefined : parent.right
        }

        placeholderText: "Username"
        placeholderTextColor: theme.current.subtle
        horizontalAlignment: Text.AlignHCenter
        color: theme.current.text

        font {
            family: config.Font 
            pointSize: root.fontSize * 1.25
        }
        

        background: Rectangle {
            anchors.fill: parent 
            color: fieldsBGAlpha

            border {
                width: 2
                color: fieldsBGSolid
            }

            radius: config.Roundigs || 25
        }

    }

    TextField {
        id: passwordField
        width: parent.width * 0.5 
        height: root.fontSize * 4.5

        anchors {
            left: root.formIsLeft ? parent.left : undefined 
            right: root.formIsLeft ? undefined : parent.right
        }

        placeholderText: "Password"
        placeholderTextColor: theme.current.subtle
        horizontalAlignment: Text.AlignHCenter
        color: theme.current.text

        font {
            family: config.Font 
            pointSize: root.fontSize * 1.25
        }

        echoMode: TextInput.Password

        background: Rectangle {
            anchors.fill: parent 
            color: fieldsBGAlpha

            border {
                width: 2
                color: fieldsBGSolid
            }

            radius: config.Roundigs || 25
        }
    }
}
