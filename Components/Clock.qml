import QtQuick 2.15
import QtQuick.Controls 2.4

Column {
    id: clock 
    width: parent.width / 2

    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: config.FontSize * 1.5
        color: config.Text
        renderType: Text.QtRendering
        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat)
        }
    }

    Label {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: config.FontSize / 2
        color: config.Text
        renderType: Text.QtRendering
        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat)
        }
    }

    Timer {
        interval: 1000 
        repeat: true 
        running: true 
        onTriggered: {
            timeLabel.updateTime()
            dateLabel.updateTime()
        }
    }

    Component.onCompleted: {
        dateLabel.updateTime()
        timeLabel.updateTime()
    } 
} 
