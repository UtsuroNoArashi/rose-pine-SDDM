import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Column {
    id: inputsRoot
    spacing: 10

    property bool failed

    Row {
        id: userField

        width: parent.width
        anchors.left: parent.left

        Label {
            id: statusLabel
            text: "Login as: "
            color: theme.text

            font {
                family: root.fontFamily
                pointSize: root.fontSize * 1.75
            }
        }

        ComboBox {
            id: userList
            width: parent.width / 2
            height: root.fontSize * 3.25

            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"

            background: Item {}
            indicator: Rectangle {
                width: 32
                height: 32

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                color: "transparent"

                Image {
                    width: 24
                    height: 24
                    source: Qt.resolvedUrl("../Assets/user.svg")
                    anchors.centerIn: parent
                    layer {
                        enabled: true
                        effect: ColorOverlay {
                            id: userIndicatorColor
                            color: userList.hovered || userList.popup.visible ? theme.accent : theme.text
                        }
                    }
                }
            }

            contentItem: Label {
                id: username
                text: textConstants.userName
                color: text === textConstants.userName ? theme.subtle : theme.accent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                font {
                    family: root.fontFamily
                    pointSize: root.fontSize * 1.75
                    underline: true
                    capitalization: Font.Capitalize
                }
            }

            popup: Popup {
                width: parent.width
                height: Math.min(contentItem.implicitHeight, userList.Window.height - topMargin - bottomMargin)
                y: parent.y - contentHeight - 10

                background: Rectangle {
                    color: theme.mapToAlpha(theme.overlay, 0.4)
                    border {
                        color: theme.overlay
                        width: 3
                    }
                    radius: config.Roundings * 0.3 || 15
                }

                contentItem: ListView {
                    clip: true
                    implicitHeight: Math.min(200, contentHeight + 10)
                    model: userList.popup.visible ? userList.delegateModel : null
                    currentIndex: userList.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {}
                }
            }

            delegate: ItemDelegate {
                width: parent.width * 0.95
                height: root.fontSize * 4

                contentItem: Text {
                    text: model.name
                    color: theme.text
                    elide: Text.ElideRight

                    font {
                        family: root.fontFamily
                        pointSize: root.fontSize * 1.25
                        capitalization: Font.Capitalize
                    }

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                background: Item {}
            }

            onActivated: {
                username.text = userList.currentText;
                passwordField.forceActiveFocus();
                passwordField.text = "";
            }
        }
    }

    TextField {
        id: passwordField
        width: parent.width
        height: root.fontSize * 4

        placeholderText: textConstants.password
        placeholderTextColor: theme.subtle

        color: theme.text
        echoMode: TextInput.Password
        horizontalAlignment: TextInput.AlignHCenter

        font {
            family: root.fontFamily
            pointSize: activeFocus ? root.fontSize * 1.25 : root.fontSize * 1.5
        }

        background: Rectangle {
            anchors.fill: parent

            color: theme.mapToAlpha(theme.surface, 0.4)

            border {
                color: theme.surface
                width: 3
            }

            radius: config.Roundings || 20
        }

        Keys.onPressed: $ => {
            if (($.key === Qt.Key_Return) || ($.key === Qt.Key_Enter))
                sddm.login(username.text.toLowerCase(), passwordField.text, root.selectedSession);
        }
    }

    Label {
        id: errorMessage
        text: textConstants.loginFailed + "!"

        color: theme.accent3
        font {
            family: root.fontFamily
            pointSize: root.fontSize * 1.2
            italic: true
        }
        verticalAlignment: Text.AlignVCenter
        opacity: failed ? 1 : 0
    }

    CheckBox {
        id: showPassword

        indicator: Rectangle {
            width: 24
            height: 24

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            color: theme.mapToAlpha(theme.surface, 0.4)
            border {
                color: theme.surface
                width: 2
            }

            Rectangle {
                width: 16
                height: 16

                anchors.centerIn: parent
                color: theme.overlay
                visible: showPassword.checked
            }
        }

        contentItem: Label {
            text: textConstants.showPasswordPrompt
            color: theme.text
            font {
                family: root.fontFamily
                pointSize: root.fontSize * 1.2
                underline: true
            }
            verticalAlignment: Text.AlignVCenter
            leftPadding: showPassword.indicator.width + showPassword.spacing
        }

        onToggled: {
            passwordField.echoMode = passwordField.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password;
        }
    }

    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            failed = true
            passwordField.text = ""
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }

    Component.onCompleted: {
        username.text = userList.currentText;
        passwordField.forceActiveFocus();
    }
}
