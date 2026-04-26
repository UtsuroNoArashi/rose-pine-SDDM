import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import SddmComponents

Item {
    id: systemTray
    property var tracker: null
    property int threshold: 150

    readonly property bool isNear: tracker !== null && dist < threshold
    readonly property real dist: {
        if (!tracker)
            return Infinity;

        var mp = systemTray.parent.mapFromItem(tracker.parent      // tracker lives in root
        , tracker.mouseX, tracker.mouseY);

        var cx = systemTray.x + systemTray.width / 2;
        var cy = systemTray.y + systemTray.height / 2;
        var dx = mp.x - cx;
        var dy = mp.y - cy;

        return Math.sqrt(dx * dx + dy * dy);
    }

    property var suspend: ["suspend", textConstants.suspend, sddm.canSuspend]
    property var reboot: ["reboot", textConstants.reboot, sddm.canReboot]
    property var shutdown: ["shutdown", textConstants.shutdown, sddm.canPowerOff]

    onIsNearChanged: {
        systemTray.opacity = isNear ? 1 : 0;
    }

    TextConstants {
        id: textConstants
    }

    Rectangle {
        anchors.fill: parent
        color: theme.mapToAlpha(theme.surface, 0.4)

        border {
            color: theme.surface
            width: 3
        }

        radius: config.Roundings || 50

        RowLayout {
            anchors.fill: parent

            Repeater {
                model: [systemTray.shutdown, systemTray.reboot, systemTray.suspend]

                RoundButton {
                    id: icon
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData[1]
                    font.pointSize: root.fontSize * 0.8

                    icon {
                        source: modelData ? Qt.resolvedUrl("../Assets/" + modelData[0] + ".svg") : ""
                        height: 32
                        width: 32
                    }

                    visible: modelData[2]

                    hoverEnabled: true
                    palette.buttonText: parent.children[index].hovered ? theme.accent : theme.text

                    background: Item {}

                    Keys.onReturnPressed: clicked()

                    onClicked: {
                        parent.forceActiveFocus();
                        switch (index) {
                        case 0:
                            sddm.powerOff();
                        case 1:
                            sddm.reboot();
                        case 2:
                            sddm.suspend();
                        }
                    }
                }
            }
        }
    }
}
