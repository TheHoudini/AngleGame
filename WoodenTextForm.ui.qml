import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    id: item1
    width: 300
    height: 150
    opacity: 0.5
    property string lblText : "text"
    property int lblSize : 12
    property int minHeight : text1.contentHeight

    Image {
        id: image1
        opacity: 1
        visible: false
        anchors.fill: parent
        source: "WoodenUi/images/dark_wood.jpg"
    }

    Text {
        id: text1
        text: lblText
        font.family: "Times New Roman"
        opacity: 1
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: lblSize
        wrapMode: Text.Wrap
    }


    OpacityMask {
            anchors.fill: image1
            source: image1
            maskSource: text1
        }
}

