import QtQuick
import QtQuick.Controls

Column {
    id: clockWidget

    Label {
        id: timeLabel
        color: theme.current.text 
        horizontalAlignment: root.formIsLeft ? Text.AlignLeft : Text.AlignRight

        anchors {
            left: root.formIsLeft ? undefined : parent.left
            right: root.formIsLeft ? parent.right : undefined
        }

        font {
            family: config.Font
            pointSize: root.fontSize * 7.5
        }

        function updateLabel() {
            text = new Date().toLocaleString(Qt.locale(config.Locale), config.HourFormat);
        }
    }

    Label {
        id: dateLabel
        color: theme.current.text
        horizontalAlignment: Text.AlignLeft

        anchors {
            left: root.formIsLeft ? undefined : parent.left
            right: root.formIsLeft ? parent.right : undefined
        }

        font {
            family: config.Font
            pointSize: root.fontSize * 3
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
