import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Components"

Item {
    id: root

    width: Screen.width
    height: Screen.height

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

            if (config.DeclareTheme)
                return theme.createTheme(config.NewBase, config.NewSurface, config.NewOverlay, config.NewText, config.NewSubtle, config.NewAccent, config.NewAccent2, config.NewAccent3);

            return main;
        }
        current: applyTheme()
    }

    Background {
        color: theme.current.base
        source: Qt.resolvedUrl("./Backgrounds/Wallpaper.jpg")
    }

    GridLayout {
        /*TODO:
          * > Toolbar: sessionSelector, keyboardSelector, systemButtonsTray, virtualKeyboard?!?
          *
          * > Clock: time and date (onHovered: change both date and hour format)
          *
          * > Login panel: yet to decide. See below for ideas
          * >> i. Classic user and password text fields  + login button
          * >> ii. userSelector (ComboBox) + password text field + login button
          * >> iii. As (ii.) but the password text field is presented in an overlay panel
          * >> iv. All the above decided by some config option
          * */
    }
}
