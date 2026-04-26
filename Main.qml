import QtQuick
import QtQuick.Layouts
import "Components"

Item {
    id: root

    width: Screen.width
    height: Screen.height

    readonly property int fontSize: {
        if (config.ForceFontSize === "true")
            return config.FontSize ? config.FontSize : parseInt((width / 1920) * 10);

        return parseInt((width / 1920) * 10);
    }

    readonly property var fontFamily: config.Font !== "" ? config.Font : "Adwaita Sans"

    property int selectedSession: 0

    ThemeBuilder {
        id: theme

        function applyTheme() {
            if (config.Variant !== "") {
                switch (config.Variant) {
                case "main":
                    return main;
                case "moon":
                    return moon;
                case "dawn":
                    return dawn;
                default:
                    console.log(`Variant ${config.Variant} unknown. Loading default.`);
                    return main;
                }
            }

            if (config.DeclareTheme === "true")
                return theme.createTheme(config.NewBase, config.NewSurface, config.NewOverlay, config.NewText, config.NewSubtle, config.NewAccent, config.NewAccent2, config.NewAccent3);

            return moon;
        }
        current: applyTheme()
    }

    Background {
        id: wallpaper
        colorBG: theme.current.base
        source: Qt.resolvedUrl(config.Background)
    }

    MouseArea {
        id: globalTracker
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
    }

    GridLayout {
        id: rootLayout
        rows: 3
        columns: 3
        uniformCellHeights: true

        anchors {
            fill: parent
            margins: config.Margins || 25
        }

        SystemTray {
            Layout.columnSpan: 3
            Layout.preferredHeight: 50
            Layout.preferredWidth: parent.width / 5
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.row: 0
            tracker: globalTracker
        }

        Clock {
            Layout.preferredWidth: parent.width / 3.5
            Layout.alignment: Qt.AlignVCenter | (config.FormPosition === "left" ? Qt.AlignRight : Qt.AlignLeft)
            Layout.column: (config.FormPosition === "left" ? 2 : 0)
            Layout.row: 1
        }

        LoginForm {
            Layout.preferredWidth: parent.width / 4
            Layout.alignment: Qt.AlignVCenter | (config.FormPosition === "left" ? Qt.AlignLeft : Qt.AlignRight)
            Layout.column: (config.FormPosition === "left" ? 0 : 2)
            Layout.row: 1
        }

        SessionSelector {
            Layout.columnSpan: 3
            Layout.preferredHeight: 50 
            Layout.preferredWidth: parent.width / 10
            Layout.row: 2 
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            tracker: globalTracker
        }
    }

    /* TODO:
    * > Toolbar: keyboardSelector, systemButtonsTray, virtualKeyboard?!?
    * */

}
