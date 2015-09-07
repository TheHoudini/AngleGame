import QtQuick 2.4
import QtQuick.Layouts 1.1

AngleFrameForm {
    Layout.minimumHeight: 50
    Layout.minimumWidth:  50
    Layout.fillHeight: true
    Layout.fillWidth: true

  //  image.sourceSize.width: 200
//    image.sourceSize.height: 200

    property bool isEmpty : true
    property int ownerId : 0

    function setBackground(color){
        rect.color = color
    }

    function setImage(img)
    {
        image.source = img
    }
    function hideImage()
    {
        image.visible = false
    }
    function showImage()
    {
        image.visible = true
    }


}
