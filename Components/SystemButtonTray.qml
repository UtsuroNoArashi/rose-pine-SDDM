import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    spacing: config.FontSize

    property var suspend: ["Suspend", sddm.canSuspend]
    property var hibernate: ["Hibernate", sddm.canHibernate]
    property var reboot: ["Reboot", sddm.canReboot]
    property var shutdown: ["Shutdown", sddm.canPowerOff]

    Repeater {
        id: systemButtons

        model: [suspend, hibernate, reboot, shutdown]

        RoundButton {
            text: modelData[0]
            font.pointSize: fontSize * 0.75
            font.family: fontFamily

            Layout.alignment: Qt.AlignHCenter

            icon {
                height: fontSize * 3.5
                width: fontSize * 3.5
                source: modelData ? Qt.resolvedUrl("../Assets/" + modelData[0] + ".svgz") : ""
            }

            display: AbstractButton.TextUnderIcon

            visible: true
            hoverEnabled: true

            palette.buttonText: config.Subtle
            background: Rectangle {
                height: 2
                color: "transparent"
                width: parent.width
                anchors.top: parent.bottom
            }

            Keys.onReturnPressed: clicked()
            onClicked: {
                parent.forceActiveFocus();
                index == 0 ? sddm.suspend() : index == 1 ? sddm.hibernate() : index == 2 ? sddm.reboot() : sddm.powerOff();
            }

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
                        palette.buttonText: mainTexts
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
