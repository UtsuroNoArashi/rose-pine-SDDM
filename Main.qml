import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Components"

Item {
    id: root

    width: Screen.width
    height: Screen.height

    readonly property int fontSize: config.ForceFontSize == "true" ? parseInt(config.FontSize) : parseInt((width / 1920) * 10)
    readonly property bool formIsLeft: config.FormPosition == "left"
    property int selectedSession

    ThemeBuilder {
        id: theme

        function applyTheme() {
            if (config.Variant != "") {
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

            if (config.DeclareTheme == "true")
                return theme.createTheme(config.NewBase, config.NewSurface, config.NewOverlay, config.NewText, config.NewSubtle, config.NewAccent, config.NewAccent2, config.NewAccent3);

            return moon;
        }
        current: applyTheme()
    }

    Background {
        id: wallpaper
        color: theme.current.base
        source: Qt.resolvedUrl(config.Background)
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
            Layout.column: root.formIsLeft ? 2 : 0
            Layout.alignment: root.formIsLeft ? Qt.AlignRight : Qt.AlignLeft
        }

        LoginForm {
            Layout.preferredWidth: parent.width / 4
            Layout.preferredHeight: parent.height / 4
            Layout.row: 1
            Layout.column: root.formIsLeft ? 0 : 2
            Layout.alignment: root.formIsLeft ? Qt.AlignLeft : Qt.AlignRight
        }

        ToolBar {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: root.fontSize * 4.5
            Layout.row: 2
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: config.Margins / 2 || 25
        }
    }

    /* TODO:
    * > Toolbar: sessionSelector, keyboardSelector, systemButtonsTray, virtualKeyboard?!?
    *
    * > Clock: fix text positioning with respect to the loaded layout
    *
    * > Login panel: yet to decide. See below for ideas
    * >> i. Classic user and password text fields  + login button
    * >> ii. userSelector (ComboBox) + password text field + login button
    * >> iii. As (ii.) but the password text field is presented in an overlay panel
    * >> iv. All the above decided by some config option
    * */

}
