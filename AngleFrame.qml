import QtQuick 2.4
import QtQuick.Layouts 1.1

AngleFrameForm {
    Layout.minimumHeight: 25
    Layout.minimumWidth:  25
    Layout.fillHeight: true
    Layout.fillWidth: true


    property bool isEmpty : true
    property int ownerId : 0

    function setBackground(color){
        rect.color = color
    }

    function setImage(img)
    {
        image.source = img
        image.visible = true
    }

    function setOpacity(op)
    {
        imgOpacity = op
    }


}
