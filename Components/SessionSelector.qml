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
            var availableIcons = ["hyprland", "plasma", "gnome", "ubuntu", "sway", "awesome", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
            for (var i = 0; i < availableIcons.length; i++) {
                if (name && name.toLowerCase().includes(availableIcons[i]))
                    return "../Assets/Sessions/" + availableIcons[i] + ".svg";
            }
            return "../Assets/Sessions/default.svg";
        }
        background: Item {}
        indicator: Item {}

        contentItem: Item {
            Row {
                anchors.centerIn: parent
                spacing: 15

                Image {
                    width: 28
                    height: 28

                    source: sessionSelector.getSessionIcon(sessionSelector.currentText)

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    layer {
                        enabled: true
                        effect: ColorOverlay {
                            color: theme.accent2
                        }
                    }
                }

                Text {
                    text: sessionSelector.currentText
                    color: theme.text
                    elide: Text.ElideRight
                    height: parent.height
                    width: sessionSelector.width / 2

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    font {
                        family: config.Font
                        pointSize: root.fontSize * 1.3
                    }
                }
            }
        }

        popup: Popup {
            width: parent.width
            height: Math.min(contentItem.implicitHeight, sessionSelector.Window.height - topMargin - bottomMargin)
            padding: 5
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
                model: sessionSelector.popup.visible ? sessionSelector.delegateModel : null
                currentIndex: sessionSelector.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator {}
            }
        }

        delegate: ItemDelegate {
            width: parent.width * 0.95
            height: root.fontSize * 4
            anchors.left: parent.left

            contentItem: Item {
                Row {
                    anchors.centerIn: parent
                    spacing: 15

                    Image {
                        width: 28
                        height: 28

                        source: sessionSelector.getSessionIcon(model.name)

                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                        layer {
                            enabled: true
                            effect: ColorOverlay {
                                color: theme.accent2
                            }
                        }
                    }

                    Text {
                        text: model.name
                        color: theme.text
                        elide: Text.ElideRight
                        height: parent.height
                        width: sessionSelector.width / 2

                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                        font {
                            family: config.Font
                            pointSize: root.fontSize * 1.3
                        }
                    }
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
