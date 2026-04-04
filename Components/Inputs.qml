import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Column {
    id: inputsRoot
    spacing: 10

    Row {
        id: userField
        // property alias urername: username.text
        // property alias lastUser: userList.currentText

        width: parent.width
        anchors.left: parent.left

        Label {
            id: statusLabel
            text: "Login as: "
            color: theme.text
            verticalAlignment: Text.AlignVCenter

            font {
                family: config.Font
                pointSize: root.fontSize * 1.5
            }
        }

        ComboBox {
            id: userList
            width: parent.width / 2
            height: root.fontSize * 3

            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"

            background: Item {}
            indicator: Rectangle {
                width: 28
                height: 28

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                color: "transparent"

                Image {
                    width: 24
                    height: 24
                    source: Qt.resolvedUrl("../Assets/user.svg")
                    layer {
                        enabled: true
                        effect: ColorOverlay {
                            id: userIndicatorColor
                            color: theme.text
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
                    family: config.Font
                    pointSize: root.fontSize * 1.5
                    underline: true
                    capitalization: Font.Capitalize
                }
            }

            popup: Popup {
                width: parent.width
                height: Math.min(contentItem.implicitHeight, userList.Window.height - topMargin - bottomMargin)
                padding: 1
                y: parent.y - contentHeight - 10

                background: Rectangle {
                    color: theme.mapToAlpha(theme.surface, 0.4)
                    border {
                        color: theme.surface
                        width: 3
                    }
                    radius: config.Roundings * 0.3 || 15
                }

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight * 1.1
                    model: userList.popup.visible ? userList.delegateModel : null
                    currentIndex: userList.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {}
                }
            }

            delegate: ItemDelegate {
                width: parent.width * 0.95
                height: root.fontSize * 4
                anchors.horizontalCenter: parent.horizontalCenter

                contentItem: Text {
                    text: model.name
                    color: theme.text
                    elide: Text.ElideRight

                    font {
                        family: config.Font
                        pointSize: root.fontSize * 1.1
                        capitalization: Font.Capitalize
                    }

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                background: Rectangle {
                    color: "transparent"
                }
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
        height: root.fontSize * 3.5

        placeholderText: textConstants.password
        placeholderTextColor: theme.subtle

        color: theme.text
        echoMode: TextInput.Password
        horizontalAlignment: TextInput.AlignHCenter

        font {
            family: config.Font
            pointSize: activeFocus ? root.fontSize : root.fontSize * 1.5
        }

        background: Rectangle {
            anchors.fill: parent

            color: theme.mapToAlpha(theme.overlay, 0.4)

            border {
                color: theme.overlay
                width: 2
            }

            radius: config.Roundings || 20
        }

        Keys.onPressed: $ => {
            console.log(`\Username: ${username.text.toLowerCase()}\nPassword: ${passwordField.text}\nSession: ${root.selectedSession}`);

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

            color: theme.mapToAlpha(theme.overlay, 0.4)
            border {
                color: theme.overlay
                width: 2
            }

            Image {
                width: 20
                height: 20
                anchors.centerIn: parent

                source: Qt.resolvedUrl("../Assets/check.svg")
                visible: showPassword.checked
                layer {
                    enabled: true
                    effect: ColorOverlay {
                        color: theme.text
                    }
                }
            }
        }

        contentItem: Label {
            text: textConstants.showPasswordPrompt
            color: theme.text
            font {
                family: config.Font
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

    Component.onCompleted: {
        var user = userList.currentText;
        username.text = user.charAt(0).toUpperCase() + user.slice(1);
        passwordField.forceActiveFocus();
    }
}
