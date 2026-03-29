import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Column {
    id: clock

    Label {
        id: timeLabel
        font.family: fontFamily
        font.pointSize: fontSize * 5 

        anchors.horizontalCenter: parent.horizontalCenter

        color: mainTexts
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat);
        }
    }

    Label {
        id: dateLabel
        font.pointSize: fontSize * 2
        font.family: fontFamily

        anchors.horizontalCenter: parent.horizontalCenter
        
        color: mainTexts
        renderType: Text.QtRendering
        
        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat);
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.updateTime();
            dateLabel.updateTime();
        }
    }

    Component.onCompleted: {
        dateLabel.updateTime();
        timeLabel.updateTime();
    }
}
