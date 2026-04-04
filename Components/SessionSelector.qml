import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    Rectangle {
        anchors.fill: parent
        color: theme.mapToAlpha(theme.overlay, 0.4)

        border {
            color: theme.overlay
            width: 2
        }

        radius: config.Roundings || 50
    }

    ComboBox {
        id: sessionSelector
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        function getSessionIcon(name) {
            var available_session_icons = ["hyprland", "plasma", "gnome", "ubuntu", "sway", "awesome", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
            for (var i = 0; i < available_session_icons.length; i++) {
                if (name && name.toLowerCase().includes(available_session_icons[i]))
                    return "../Assets/Sessions/" + available_session_icons[i] + ".svg";
            }
            return "../Assets/Sessions/default.svg";
        }
        background: Item {}
        indicator: Item {}

        contentItem: RowLayout {
            spacing: 10
            width: parent.width
            clip: true

            anchors {
                fill: parent
                leftMargin: config.Margins / 2 || 25
                rightMargin: config.Margins / 2 || 25
            }

            Image {
                width: 24
                height: 24
                source: sessionSelector.getSessionIcon(sessionSelector.currentText)

                layer {
                    enabled: true
                    effect: ColorOverlay {
                        color: theme.accent2
                    }
                }

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }

            Text {
                text: sessionSelector.currentText
                color: theme.text

                elide: Text.ElideLeft
                font {
                    family: config.Font
                    pointSize: root.fontSize * 1.2
                }

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }

        popup: Popup {
            width: parent.width
            height: Math.min(contentItem.implicitHeight, sessionSelector.Window.height - topMargin - bottomMargin)
            padding: 5
            y: parent.y + parent.height + 10

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
                model: sessionSelector.popup.visible ? sessionSelector.delegateModel : null
                currentIndex: sessionSelector.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator {}
            }
        }

        delegate: ItemDelegate {
            width: parent.width * 0.95
            height: root.fontSize * 4
            anchors.left: parent.left

            contentItem: Row {
                spacing: 10
                width: parent.width
                anchors {
                    leftMargin: config.Margins / 2 || 25
                    rightMargin: config.Margins / 2 || 25
                }

                Image {
                    width: 24
                    height: 25
                    source: sessionSelector.getSessionIcon(model.name)

                    layer {
                        enabled: true
                        effect: ColorOverlay {
                            color: theme.accent2
                        }
                    }

                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                }

                Text {
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
            }

            background: Rectangle {
                color: "transparent"
            }
        }

        onActivated: {
            root.selectedSession = sessionSelector.currentIndex;
        }
    }

    Component.onCompleted: {
        root.selectedSession = sessionSelector.model.lastIndex;
    }
}
