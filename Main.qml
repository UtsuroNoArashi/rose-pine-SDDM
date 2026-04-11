import QtQuick
import QtQuick.Layouts
import "Components"

Item {
    id: root

    width: Screen.width
    height: Screen.height

    readonly property int fontSize: config.ForceFontSize === "true" ? config.FontSize : parseInt((width / 1920) * 10)
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
        rows: 3
        columns: 3
        anchors {
            fill: parent
            leftMargin: config.Margins || 50
            rightMargin: config.Margins || 50
        }

        Clock {
            Layout.preferredWidth: parent.width / 3
            Layout.row: 1
            Layout.column: config.FormPosition === "left" ? 2 : 0
            Layout.alignment: config.FormPosition === "left" ? Qt.AlignRight : Qt.AlignLeft
        }

        LoginForm {
            Layout.preferredWidth: parent.width / 4
            Layout.preferredHeight: parent.height / 4
            Layout.row: 1
            Layout.column: config.FormPosition === "left" ? 0 : 2
            Layout.alignment: config.FormPosition === "left" ? Qt.AlignLeft : Qt.AlignRight
        }

        SessionSelector {
            Layout.preferredWidth: parent.width / 10
            Layout.preferredHeight: 50
            Layout.row: 2
            Layout.column: 0
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.bottomMargin: config.Margins / 2 || 25
            tracker: globalTracker
        }
    }

    /* TODO:
    * > Toolbar: keyboardSelector, systemButtonsTray, virtualKeyboard?!?
    * */

}
