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
    readonly property bool layoutIsClassic: config.Layout == "classic"
    
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
        source: Qt.resolvedUrl("./Backgrounds/Wallpaper.jpg")
    }

    GridLayout {
        columns: 3
        rows: 3
        anchors {
            fill: parent 
            leftMargin: config.Margins || 75
            rightMargin: config.Margins || 75
        }

        Clock {
            Layout.preferredWidth: parent.width / 3
            Layout.row: 1 
            Layout.column: 0
            Layout.alignment: (root.formIsLeft ? Qt.AlignRight : Qt.AlignLeft)
        }

        Inputs {
            Layout.preferredWidth: parent.width / 3 
            Layout.row: 1 
            Layout.column: 2 
            Layout.alignment: root.formIsLeft ? Qt.AlignLeft : Qt.AlignRight
        }


        /*TODO:
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
}
