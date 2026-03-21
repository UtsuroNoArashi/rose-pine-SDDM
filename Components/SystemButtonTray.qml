import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

RowLayout {
    spacing: config.FontSize  

    property var suspend: ["Suspend", sddm.canSuspend]
    property var hibernate: ["Hibernate", sddm.canHibernate]
    property var reboot: ["Reboot", sddm.canReboot]
    property var shutdown: ["Shutdown", sddm.canPowerOff]

    property Control exposedSession

    Repeater {
        id: systemButtons

        model: [suspend, hibernate, reboot, shutdown]

        RoundButton {
            text: modelData[0]
            font.pointSize: config.FontSize * 0.75

            Layout.alignment: Qt.AlignHCenter
            icon.source: modelData ? Qt.resolvedUrl("../Assets/" + modelData[0] + ".svgz") : ""
            icon.height: config.FontSize * 3
            icon.width: config.FontSize * 3.5

            display: AbstractButton.TextUnderIcon
            visible: true
            hoverEnabled: true

            palette.buttonText: config.Muted
            background: Rectangle {
                height: 2
                color: "transparent"
                width: parent.width
                border.width: parent.activeFocus ? 1 : 0
                border.color: "transparent"
                anchors.top: parent.bottom
            }

            Keys.onReturnPressed: clicked()
            onClicked: {
                parent.forceActiveFocus();
                index == 0 ? sddm.suspend() 
                        : index == 1 ? sddm.hibernate() 
                        : index == 2 ? sddm.reboot() 
                        : sddm.powerOff();
            }

            KeyNavigation.up: exposedSession
            KeyNavigation.left: parent.children[index - 1]

            states: [
                State {
                    name: "Pressed"
                    when: down
                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: config.Rose
                    }
                },

                State {
                    name: "Hovered"
                    when: hovered
                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: config.Text
                    }
                },

                State {
                    name: "Focused"
                    when: activeFocus
                    PropertyChanges {
                        target: parent.children[index]
                        palette.buttonText: config.HighlightMed
                    }
                }

            ]

            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "palette.buttonText"
                        duration: 150
                    }
                }
            ]
        }
    }
}
