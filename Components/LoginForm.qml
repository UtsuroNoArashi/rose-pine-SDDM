import QtQuick 2.14
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4 as Controls
import SddmComponents 2.0

Rectangle {
    id: formBG
    color: "transparent"
    width: parent.width * 0.3

    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
    }

    Column {
        id: formContainer

        anchors.centerIn: parent
        spacing: 20

        Controls.TextField {
            id: userField
            width: formBG.width * 0.5
            height: config.FontSize * 3

            placeholderText: "Username"
            placeholderTextColor: config.Subtle

            color: config.Text
            font.pointSize: config.FontSize * 1.125

            horizontalAlignment: TextInput.AlignHCenter

            background: Rectangle {
                anchors.fill: parent
                property color inputBG: config.Surface

                color: Qt.rgba(inputBG.r, inputBG.g, inputBG.b, 0.5)
                radius: 20
            }
        }

        Controls.TextField {
            id: passField
            width: formBG.width * 0.5
            height: config.FontSize * 3

            placeholderText: "Password"
            placeholderTextColor: config.Subtle

            color: config.Text
            font.pointSize: activeFocus ? config.FontSize * 0.75 : config.FontSize * 1.125
            echoMode: TextInput.Password

            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter

            background: Rectangle {
                anchors.fill: parent

                property color inputBG: config.Surface

                color: Qt.rgba(inputBG.r, inputBG.g, inputBG.b, 0.5)
                radius: 20
            }
        }

        Controls.Button {
            text: "Login"
            width: formBG.width * 0.5

            contentItem: Text {
                text: parent.text
                color: config.Text
                font.pointSize: config.FontSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                width: parent.width
                height: config.FontSize * 3
                radius: 20          // pill shape — match your text fields

                property color btnBG: config.Rose
                color: parent.pressed ? "red" : Qt.rgba(btnBG.r, btnBG.g, btnBG.b, 0.5)
            }

            onClicked: sddm.login(userField.text, passField.text, sessionCombo.currentIndex)
        }

    }

    ComboBox {
        id: sessionCombo
        model: sessionModel
        // textRole: "name"
    }

    Connections {
        target: sddm
        onLoginFailed: {
            passField.text = ""
            passField.focus = true
        }
    }
}
