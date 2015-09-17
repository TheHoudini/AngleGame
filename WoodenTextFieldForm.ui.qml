import QtQuick 2.4

Item {
    id: item1
    width: 200
    height: 50

    property alias inputText: textInput1.text
    property int maxLength : 10
    property alias validator : textInput1.validator

    Image {
        id: image1
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        source: "WoodenUi/images/text_field.png"
    }

    TextInput {
        id: textInput1
        x: 8
        y: 17
        text: "text"
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: image1.height/4
        anchors.topMargin: image1.height/3
        font.family: "Arial"
        cursorVisible: false
        readOnly: false
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: 12
        maximumLength: maxLength
    }

    IntValidator {
        id:intValidator
        bottom: 1
        top: 1000
    }
}

