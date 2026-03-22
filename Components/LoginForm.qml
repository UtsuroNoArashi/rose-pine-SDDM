import QtQuick 2.14
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import SddmComponents 2.0

Rectangle {
    // SessionModel { id: sessionModel }

    Column {
        TextField { id: userField;     placeholderText: "Username" }
        TextField { id: passwordField; placeholderText: "Password"; echoMode: TextInput.Password }

        ComboBox {
            id: sessionCombo
            model: sessionModel
            // textRole: "name"
        }

        Button {
            text: "Connect"
            onClicked: sddm.login(userField.text, passwordField.text, sessionCombo.currentIndex)
        }
    }

    Connections {
        target: sddm
        onLoginFailed: { passwordField.text = ""; passwordField.focus = true }
    }
}
