import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    id: item1
    width: 50
    height: 50

    property double boxShadowRight : 3
    property double boxShadowBot : 3


    Image {
        id: background
        opacity: 0
        anchors.fill: parent
        visible: false
        source: "../image/background.png"


    }

    WoodenCircle {
        id: woodenCircle1
        scale: 1
        anchors.fill: parent
    }



    DropShadow {
            anchors.fill: woodenCircle1
            horizontalOffset: boxShadowRight
            verticalOffset: boxShadowBot
            radius: 4.0
            samples: 4
            color: "#80000000"
            source: woodenCircle1
        }

    DropShadow {
            anchors.fill: woodenCircle1
            horizontalOffset: - boxShadowRight
            verticalOffset: - boxShadowBot
            radius: 4.0
            samples: 4
            color: "#80000000"
            source: woodenCircle1
        }



    OpacityMask {
            id : opacMask
            anchors.fill: background
            source: background
            maskSource: woodenCircle1
        }

    InnerShadow {
            anchors.fill: opacMask
            radius: 1.0
            samples: 4
            horizontalOffset:boxShadowRight
            verticalOffset: boxShadowBot
            color: "#b0000000"
            source: opacMask
        }

    InnerShadow {
            anchors.fill: opacMask
            radius: 1.0
            samples: 4
            horizontalOffset: -boxShadowRight
            verticalOffset: -boxShadowBot
            color: "#b0000000"
            source: opacMask
    }



    Image {
        id: image1
        anchors.rightMargin: -6
        anchors.leftMargin: 6
        anchors.fill: parent
        rotation: 0
        opacity: 0.3
        scale: 0.4
        z: 0
        source: "images/arrowhead.png"
    }





}

