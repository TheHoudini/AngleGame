import QtQuick 2.4
Item {
    width: 50
    height: 40

    property alias image : img
    property alias rect : rectangle
    property double imgOpacity : 0.9

    Rectangle {
        id: rectangle
        color: "#ffffff"
        visible: true
        opacity: 0.5
        anchors.fill: parent
    }

    Image {
        id: img
        x: 9
        y: 4
        opacity: imgOpacity
        fillMode: Image.PreserveAspectFit
        visible: false
        anchors.rightMargin: 4
        anchors.leftMargin: 4
        anchors.bottomMargin: 1
        anchors.topMargin: 1
        sourceSize.height: 0
        sourceSize.width: 0
        anchors.fill: parent
        //  source: "qrc:/qtquickplugin/images/template_image.png"
    }
}

