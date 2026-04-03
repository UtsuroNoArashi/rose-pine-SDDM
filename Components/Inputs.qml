import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Column {
    id: inputsRoot
    spacing: 10

    property color fieldColor: theme.current.surface

    Row {
        id: userField
        property alias username: username.text
        property alias lastUser: userList.currentText

        anchors.left: parent.left

        Label {
            id: statusLabel
            text: "Login as: "
            color: theme.current.text
            verticalAlignment: Text.AlignVCenter

            font {
                family: config.Font
                pointSize: root.fontSize * 1.5
            }
        }

        ComboBox {
            id: userList
            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"

            delegate: ItemDelegate {
                width: parseInt(passwordField.width - userList.contentItem.width - userList.x)
                contentItem: Text {
                    text: model.name
                    elide: Text.ElideRight
                    color: theme.current.text
                    font {
                        family: config.Font
                        pointSize: root.fontSize * 1.2
                    }
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: theme.current.overlay
                }
            }

            popup: Popup {
                width: parseInt(passwordField.width - userList.contentItem.width - userList.x)
                height: Math.min(contentItem.implicitHeight, userList.Window.height - topMargin - bottomMargin)
                padding: 1
                x: userList.contentItem.x

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: userList.popup.visible ? userList.delegateModel : null
                    currentIndex: userList.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {}
                }

                background: Rectangle {
                    color: theme.current.surface
                }
            }

            contentItem: Label {
                id: username
                text: textConstants.userName
                color: text === textConstants.userName ? theme.current.subtle : theme.current.accent
                verticalAlignment: Text.AlignVCenter

                font {
                    family: config.Font
                    pointSize: root.fontSize * 1.5
                    underline: true
                }
            }

            onActivated: {
                var selectedUser = userList.currentText;
                username.text = selectedUser.charAt(0).toUpperCase() + selectedUser.slice(1);

                passwordField.forceActiveFocus();
                passwordField.text = "";
            }

            background: Rectangle {
                implicitWidth: root.fontSize * 10
                implicitHeight: root.fontSize * 3
                color: "transparent"
                border.color: "transparent"
            }

            indicator: Button {
                id: userListIndicator
                width: root.fontSize * 3
                height: root.fontSize * 3
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                icon {
                    source: Qt.resolvedUrl("../Assets/user.svg")
                    color: username.text === textConstants.userName ? theme.current.subtle : theme.current.accent
                }

                onClicked: userList.popup.open()
                background: Item {}
            }
        }
    }

    TextField {
        id: passwordField
        width: parent.width
        height: root.fontSize * 3.5

        placeholderText: textConstants.password
        placeholderTextColor: theme.current.subtle

        color: theme.current.text
        echoMode: TextInput.Password
        horizontalAlignment: TextInput.AlignHCenter

        font {
            family: config.Font
            pointSize: activeFocus ? root.fontSize : root.fontSize * 1.5
        }

        background: Rectangle {
            anchors.fill: parent

            color: Qt.rgba(fieldColor.r, fieldColor.g, fieldColor.b, 0.4)

            border {
                color: fieldColor
                width: 2
            }

            radius: config.Roundings || 20
        }

        Keys.onPressed: $ => {

            console.log(`\Username: ${username.text.toLowerCase()}\nPassword: ${passwordField.text}\nSession: ${root.selectedSession}`)

            if (($.key === Qt.Key_Return) || ($.key === Qt.Key_Enter))
                sddm.login(username.text.toLowerCase(), passwordField.text, root.selectedSession);
        }
    }

    CheckBox {
        id: showPassword
        text: "Hiii"

        indicator: Rectangle {
            width: 24
            height: 24

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            color: Qt.rgba(fieldColor.r, fieldColor.g, fieldColor.b, 0.4)
            border {
                color: fieldColor
                width: 2
            }

            Rectangle {
                width: 16
                height: 16
                anchors.centerIn: parent
                color: fieldColor
                visible: showPassword.checked
            }
        }

        contentItem: Label {
            text: textConstants.showPasswordPrompt
            color: theme.current.text
            font {
                family: config.Font
                pointSize: root.fontSize
                underline: true
            }
            verticalAlignment: Text.AlignVCenter
            leftPadding: showPassword.indicator.width + showPassword.spacing
        }

        onToggled: {
            passwordField.echoMode = passwordField.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password;
        }
    }

    Component.onCompleted: {
        var user = userList.currentText;
        username.text = user.charAt(0).toUpperCase() + user.slice(1);
        passwordField.forceActiveFocus();
    }
}
