import QtQuick 2.4
import QtQuick.Layouts 1.1

WoodenRadioButtonForm {

    id : btn
    signal toggled
    property double shadowSize : 1


    boxShadowBot: shadowSize
    boxShadowRight: shadowSize
    MouseArea {
        id : mouseArea
        anchors.fill: parent

        onPressed: press()
        onReleased:  normalize()
    }

    function press(){
        btn.x -= 2
        btn.y += 2
        btn.boxShadowBot -= btn.shadowSize
        btn.boxShadowRight -= btn.shadowSize
    }

    function normalize(){
        btn.x += 2
        btn.y -= 2
        btn.boxShadowBot += btn.shadowSize
        btn.boxShadowRight += btn.shadowSize
        toggled()
    }


}

