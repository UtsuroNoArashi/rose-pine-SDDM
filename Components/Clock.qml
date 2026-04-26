import QtQuick
import QtQuick.Controls

Column {
    id: clockWidget

    Label {
        id: timeLabel
        color: theme.text
        horizontalAlignment: Text.AlignLeft
        anchors.horizontalCenter: parent.horizontalCenter

        font {
            family: config.Font
            pointSize: root.fontSize * 7.5
            kerning: false
        }

        function updateLabel() {
            text = new Date().toLocaleString(Qt.locale(config.Locale), config.HourFormat);
        }
    }

    Label {
        id: dateLabel
        color: theme.text
        horizontalAlignment: Text.AlignLeft
        anchors.horizontalCenter: parent.horizontalCenter

        font {
            family: config.Font
            pointSize: root.fontSize * 3.75
            kerning: false
        }

        function updateLabel() {
            text = new Date().toLocaleString(Qt.locale(config.Locale), config.DateFormat);
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.updateLabel();
            dateLabel.updateLabel();
        }
    }

    Component.onCompleted: {
        timeLabel.updateLabel();
        dateLabel.updateLabel();
    }
}
