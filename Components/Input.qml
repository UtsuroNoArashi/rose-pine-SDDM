import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import Qt5Compat.GraphicalEffects
import SddmComponents

ColumnLayout {
    id: inputsRoot
    property color inputsBG: config.Surface

    Column {
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height * 0.25
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        spacing: defaultSpacings

        Item {
            width: parent.width * 0.75
            height: fontSize * 4
            anchors.horizontalCenter: parent.horizontalCenter

            Controls.TextField {
                id: userField
                width: parent.width
                height: fontSize * 3

                anchors.centerIn: parent

                placeholderText: "Username"
                placeholderTextColor: config.Subtle

                color: mainTexts
                horizontalAlignment: TextInput.AlignHCenter
                font {
                    family: fontFamily
                    pointSize: fontSize
                }

                background: Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(inputsBG.r, inputsBG.g, inputsBG.b, 0.4)
                    radius: defaultRoundings
                    border {
                        width: 2
                        color: config.HighlightLow
                    }
                }
            }

            Controls.ComboBox {
                id: userSelector
                model: userModel
                currentIndex: model.lastIndex
                textRole: "name"

                anchors.fill: userField

                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                contentItem: {}

                popup: Controls.Popup {
                    y: userSelector.height
                    width: userSelector.width
                    padding: 0

                    background: Rectangle {
                        color: inputsBG
                    }

                    contentItem: ListView {
                        implicitHeight: contentHeight
                        model: userSelector.delegateModel
                        clip: true
                    }
                }

                delegate: Controls.ItemDelegate {
                    width: userSelector.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    contentItem: Text {
                        text: model.name
                        color: mainTexts
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: config.Overlay
                    }
                }

                indicator: Controls.Button {
                    id: userSelectorIcon
                    width: 36
                    height: 36
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: 5
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                    }

                    icon {
                        color: mainTexts
                        source: Qt.resolvedUrl("../Assets/User.svgz")
                    }
                }

                states: [
                    State {
                        name: "Default"
                        when: !(userSelector.activeFocus || userSelector.hovered)
                        PropertyChanges {
                            target: userSelectorIcon
                            icon.color: config.Subtle
                        }
                    },
                    State {
                        name: "Active"
                        when: userSelector.activeFocus || userSelector.hovered
                        PropertyChanges {
                            target: userSelectorIcon
                            icon.color: config.Rose
                        }
                    }
                ]

                onActivated: {
                    userField.text = currentText.charAt(0).toUpperCase() + currentText.slice(1);
                    passwordField.focus = true;
                    passwordField.text = "";
                }
            }
        }

        Controls.TextField {
            id: passwordField
            width: parent.width * 0.75
            height: fontSize * 3
            anchors.horizontalCenter: parent.horizontalCenter

            placeholderText: "Password"
            placeholderTextColor: config.Subtle

            color: mainTexts
            horizontalAlignment: TextInput.AlignHCenter
            echoMode: TextInput.Password

            font.family: fontFamily

            Keys.onPressed: event => {
                if ((event.key == Qt.Key_Enter) || (event.key == Qt.Key_Return) && (passwordField.text !== ""))
                    sddm.login(userField.text, passwordField.text, 0);
            }

            background: Rectangle {
                anchors.fill: parent

                color: Qt.rgba(inputsBG.r, inputsBG.g, inputsBG.b, 0.375)
                radius: defaultRoundings
                border {
                    width: 2
                    color: inputsBG
                }
            }

            states: [
                State {
                    name: "Empty"
                    when: !passwordField.activeFocus
                    PropertyChanges {
                        target: passwordField
                        font.pointSize: fontSize
                    }
                },
                State {
                    name: "Active"
                    when: passwordField.activeFocus
                    PropertyChanges {
                        target: passwordField
                        font.pointSize: fontSize * 0.8
                    }
                }
            ]
        }

        Controls.CheckBox {
            id: showPasswordCheck
            x: passwordField.x
            height: 24
            contentItem: Text {
                text: "Show password?"
                leftPadding: parent.indicator.width + parent.spacing
                color: config.Rose
                verticalAlignment: Text.AlignVCenter
                font {
                    family: fontFamily
                    pointSize: fontSize
                }
            }

            indicator: Controls.Button {
                id: checkButton
                width: 24
                height: parent.height
                anchors.left: parent.left
                checkable: true
                checked: false

                background: Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(inputsBG.r, inputsBG.g, inputsBG.b, 0.375)
                    border {
                        width: 2
                        color: inputsBG
                    }
                }

                icon {
                    color: mainTexts
                }

                states: [
                    State {
                        name: "Unchecked"
                        when: !checkButton.checked
                        PropertyChanges {
                            target: checkButton
                            icon.source: ""
                        }
                        PropertyChanges {
                            target: passwordField
                            echoMode: TextInput.Password
                        }
                    },
                    State {
                        name: "Checked"
                        when: checkButton.checked
                        PropertyChanges {
                            target: checkButton
                            icon.source: Qt.resolvedUrl("../Assets/CheckMark.svg")
                        }
                        PropertyChanges {
                            target: passwordField
                            echoMode: TextInput.Normal
                        }
                    }
                ]
            }
        }

        Controls.Label {
            id: failedLogin
            text: " "
            anchors.horizontalCenter: parent.horizontalCenter
            color: config.Love

            font {
                family: fontFamily
                pointSize: fontSize
                italic: true
            }
        }

        Controls.Button {
            id: loginButton
            width: parent.width * 0.5
            height: fontSize * 3

            anchors.horizontalCenter: parent.horizontalCenter

            contentItem: Text {
                text: "Login"
                color: mainTexts
                horizontalAlignment: Text.AlignHCenter

                font {
                    family: fontFamily
                    pointSize: fontSize * 1.125
                }
            }

            background: Rectangle {
                id: loginButtonBG
                radius: defaultRoundings
            }

            states: [
                State {
                    name: "Invalid"
                    when: passwordField.text == ""
                    PropertyChanges {
                        target: loginButtonBG
                        color: config.Overlay
                        // opacity: 0.3
                        enabled: false
                    }
                },
                State {
                    name: "Valid"
                    when: passwordField.text != ""
                    PropertyChanges {
                        target: loginButtonBG
                        color: config.Overlay
                        enabled: true
                    }
                }
            ]

            onClicked: {
                console.log(sessionModel.currentIndex);
                sddm.login(userField.text, passwordField.text, sessionModel.currentIndex);
            }
        }
    }

    // TODO: complete formatting 
    // Controls.ComboBox {
    //     model: sessionModel
    //     currentIndex: model.lastIndex
    //     textRole: "name"
    // }

    Connections {
        target: sddm

        onLoginFailed: {
            failedLogin.text = "Login failed!";

            passwordField.text = "";
            passwordField.focus = true;
        }
    }
}
