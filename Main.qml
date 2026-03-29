import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import "Components"

Rectangle {
    id: root

    width: Screen.width
    height: Screen.height

    property var fontFamily: config.Font
    property int fontSize: config.FontSize == "" ? parseInt((width * 6) / (90 * 11)) : config.FontSize
    property var mainTexts: config.Text
    property int defaultMargins: config.Margins == "" ? 50 : config.Margins
    property int defaultRoundings: config.Roundings == "" ? 20 : config.Roundings
    property int defaultSpacings: config.Spacings == "" ? 20 : config.Spacings

    Image {
        id: wallpaper

        anchors.fill: parent
        source: config.Background
        mirror: !(config.FormPosition == "right")
        fillMode: Image.preserveAspectCrop
    }

    Item {
        id: blurLayer

        width: root.width * 0.3
        height: root.height

        anchors {
            left: config.FormPosition == "left" ? root.left : undefined
            right: config.FormPosition == "right" ? root.right : undefined
            verticalCenter: root.verticalCenter
        }

        ShaderEffectSource {
            id: wallpaperCapture

            anchors.fill: parent
            sourceItem: wallpaper
            sourceRect: Qt.rect(blurLayer.x, blurLayer.y, blurLayer.width, blurLayer.height)
            hideSource: false
            live: true
        }

        MultiEffect {
            anchors.fill: parent
            source: wallpaperCapture
            blurEnabled: true
            blur: 1.0
            blurMax: 32
        }
    }

    LoginForm {}

    ColumnLayout {
        width: parent.width * 0.3
        height: parent.height * 0.9

        anchors {
            left: config.FormPosition == "left" ? undefined : parent.left
            right: config.FormPosition == "right" ? undefined : parent.right
            verticalCenter: parent.verticalCenter
        }

        Clock {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width * 0.5
            Layout.topMargin: defaultMargins
        }

        SystemButtonTray {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.preferredWidth: parent.width * 0.5
            Layout.bottomMargin: defaultMargins
        }
    }
}
