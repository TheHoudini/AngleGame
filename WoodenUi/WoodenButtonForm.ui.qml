import QtQuick 2.4

Item {
    width: 130
    height: 50

    Image {
        id: image1
        height: 68
        anchors.rightMargin: -3
        anchors.leftMargin: -3
        anchors.bottomMargin: -9
        anchors.topMargin: -5
        anchors.fill: parent
        source: "images/button_up.png"
    }

    states: [
        State {
            name: "hover"

            PropertyChanges {
                target: image1
                source: "images/button_hover.png"
            }
        },
        State {
            name: "press"

            PropertyChanges {
                target: image1
                anchors.bottomMargin: -6
                source: "images/button_down.png"
            }
        }
    ]
}

