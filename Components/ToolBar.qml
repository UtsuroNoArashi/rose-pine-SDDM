import QtQuick 
import QtQuick.Controls

Rectangle {
    property color fieldColor: theme.current.base 

    id: toolBarBG
    color: Qt.rgba(fieldColor.r, fieldColor.g, fieldColor.b, 0.4)
    border {
        color: fieldColor
        width: 2
    }
    radius: config.Roundings || 20

    Item {
        anchors.fill: parent

        ComboBox {
            id: sessionSelector 
            model: sessionModel
            currentIndex: model.lastIndex
            textRole: "name"

            anchors {
                left: parent.left 
                verticalCenter: parent.verticalCenter
                leftMargin: config.Margins / 2 || 25
            }

            onActivated: {root.selectedSession = sessionSelector.currentIndex}
        }
        /* TODO:
         * 1. Complete toobar 
         * 2. Solve reference between ToolBar and inputs 
         * */
     } 
}
