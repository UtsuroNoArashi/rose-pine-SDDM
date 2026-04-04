import QtQuick

QtObject {
    id: themeBuilder

    readonly property Component _themeFactory: Component {
        QtObject {
            property color base
            property color surface
            property color overlay
            property color text
            property color subtle
            property color accent
            property color accent2
            property color accent3
        }
    }

    function createTheme(base, surface, overlay, text, subtle, accent, accent2, accent3) {
        return _themeFactory.createObject(themeBuilder, {
            base: base,
            surface: surface,
            overlay: overlay,
            text: text,
            subtle: subtle,
            accent: accent,
            accent2: accent2,
            accent3: accent3
        });
    }

    function mapToAlpha(color, alpha) {
        return Qt.rgba(color.r, color.g, color.b, alpha)
    }

    readonly property var main: createTheme("#191724", "#1f1d2e", "#26233a", "#e0def4", "#908caa", "#ebbcba", "#9ccfd8", "#eb6f92")
    readonly property var moon: createTheme("#232136", "#2a273f", "#393552", "#e0def4", "#908caa", "#ea9a97", "#9ccfd8", "#eb6f92")
    readonly property var dawn: createTheme("#faf4ed", "#fffaf3", "#f2e9e1", "#575279", "#797593", "#d7827e", "#56949f", "#b4637a")

    property var current: main

    readonly property var base: current.base
    readonly property var surface: current.surface 
    readonly property var overlay: current.overlay
    readonly property var text: current.text 
    readonly property var accent: current.accent 
    readonly property var accent2: current.accent2
    readonly property var accent3: current.accent3
    readonly property var subtle: current.subtle

}
