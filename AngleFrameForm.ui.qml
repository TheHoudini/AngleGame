import QtQuick 2.4
Item {
    width: 50
    height: 40

    property alias image : img
    property alias rect : rectangle

    Rectangle {
        id: rectangle
        color: "#ffffff"
        opacity: 0.5
        anchors.fill: parent
    }

    Image {
        id: img
        x: 9
        y: 4
        fillMode: Image.PreserveAspectFit
        visible: false
        anchors.rightMargin: 9
        anchors.leftMargin: 9
        anchors.bottomMargin: 4
        anchors.topMargin: 4
        sourceSize.height: 0
        sourceSize.width: 0
        anchors.fill: parent
        //  source: "qrc:/qtquickplugin/images/template_image.png"
    }
}

