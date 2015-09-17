import QtQuick 2.4
import QtQuick.Layouts 1.1

WoodenButtonForm {
    id : button
    signal toggled
    Layout.fillHeight: true
    Layout.fillWidth: true
    property string textOnLabel : "Компьютер"
    property int textOnLblSize : 30

    MouseArea{
        hoverEnabled: true
        anchors.fill: parent
        onPressed: press()
        onReleased: {
            normalize()
            toggled()
        }
        onEntered: hover()
        onExited: normalize()
    }

    Text {
        id: text1
        text: textOnLabel
        style: Text.Normal
        opacity: 0.5
        wrapMode: Text.WrapAnywhere
        z: 0
        transformOrigin: Item.Center
        anchors.topMargin: -2
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: textOnLblSize
    }

    function press(){
        button.state = "press"
        text1.anchors.topMargin = 0
    }

    function normalize(){
        button.state = ""
        text1.anchors.topMargin = -2
    }
    function hover(){
        button.state = "hover"
        text1.anchors.topMargin = -2
    }

}

