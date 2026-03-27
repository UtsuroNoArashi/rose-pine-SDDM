import QtQuick 2.14
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4 as Controls
import QtGraphicalEffects 1.0
import SddmComponents 2.0

ColumnLayout {
        anchors {
            centerIn: parent
            margins: 50
        }

        spacing: 20

        // FIX 2: replaced Row with an Item so userField and userSelector
        // can both anchor to it and properly overlay each other
        Item {
            Layout.preferredWidth: formRoot.width * 0.5
            Layout.preferredHeight: config.FontSize * 3
            Layout.alignment: Qt.AlignHCenter

            Controls.TextField {
                id: userField
                // FIX 3: size now comes from the parent Item via anchors.fill;
                // removed bare width/height and illegal anchors.horizontalCenter
                anchors.fill: parent

                placeholderText: "Username"
                placeholderTextColor: config.Subtle

                color: config.Text
                font.pointSize: config.FontSize * 1.125
                font.family: config.Font

                horizontalAlignment: TextInput.AlignHCenter

                background: Rectangle {
                    anchors.fill: parent
                    property color inputBG: config.Surface

                    color: Qt.rgba(inputBG.r, inputBG.g, inputBG.b, 0.4)
                    radius: 20
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

                // FIX 4: anchors to the shared parent Item instead of a sibling
                anchors.fill: parent

                contentItem: {}

                function updateText() {
                    userField.text = currentText.charAt(0).toUpperCase() + currentText.slice(1);
                }

                onActivated: {
                    updateText();
                    passwordField.focus = true;
                    passwordField.text = "";
                }

                background: Rectangle {
                    color: "transparent"
                }

                popup: Controls.Popup {
                    y: userSelector.height
                    width: userSelector.width
                    padding: 0

                    background: Rectangle {
                        color: config.Surface
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
                        color: config.Text
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        property color selectorBG: config.Overlay
                        color: Qt.rgba(selectorBG.r, selectorBG.g, selectorBG.b, 0.4)
                    }
                }

                indicator: Controls.Button {
                    id: userSelectorIcon
                    anchors {
                        right: parent.right
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                    }

                    icon {
                        color: config.Text
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
            }
        }

        Controls.TextField {
            id: passwordField
            // FIX 5: replaced bare width/height/anchors.horizontalCenter with
            // Layout properties, which are correct inside a ColumnLayout
            Layout.preferredWidth: formRoot.width * 0.5
            Layout.preferredHeight: config.FontSize * 3
            Layout.alignment: Qt.AlignHCenter

            placeholderText: "Password"
            placeholderTextColor: config.Subtle

            color: config.Text
            horizontalAlignment: TextInput.AlignHCenter
            echoMode: TextInput.Password

            font.family: config.Font

            background: Rectangle {
                anchors.fill: parent
                property color inputBG: config.Surface

                color: Qt.rgba(inputBG.r, inputBG.g, inputBG.b, 0.4)
                radius: 20
                border {
                    width: 2
                    color: config.HighlightLow
                }
            }

            states: [
                State {
                    name: "Empty"
                    when: !passwordField.activeFocus
                    PropertyChanges {
                        target: passwordField
                        font.pointSize: config.FontSize * 1.125
                    }
                },
                State {
                    name: "Active"
                    when: passwordField.activeFocus
                    PropertyChanges {
                        target: passwordField
                        font.pointSize: config.FontSize * 0.8
                    }
                }
            ]
        }

        Controls.Button {
            id: loginButton
            text: "Login"
            Layout.topMargin: 50
            Layout.preferredWidth: formRoot.width * 0.25
            Layout.preferredHeight: config.FontSize * 3
            Layout.alignment: Qt.AlignHCenter
            font.family: config.Font 

            background: Rectangle {
                id: loginButtonBG
                radius: 20

                states: [
                    State {
                        name: "Invalid"
                        when: passwordField.text == ""
                        PropertyChanges {
                            target: loginButtonBG
                            color: config.Rose
                            opacity: 0.3
                            enabled: false
                        }
                    },
                    State {
                        name: "Valid"
                        when: passwordField.text != ""
                        PropertyChanges {
                            target: loginButtonBG
                            color: config.Rose
                            enabled: true
                        }
                    }
                ]
            }

            onClicked: sddm.login(userField.text, passwordField.text, 0)
        }

        Connections {
            target: sddm

            onLoginSucceeded: {
                console.log("Login succeeded!");
            }

            onLoginFailed: {
                passwordField.text = "";
            }
        }
    }
