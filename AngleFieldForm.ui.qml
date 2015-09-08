import QtQuick 2.4
import QtQuick.Layouts 1.2


Item {
    width: angleFrame1.width*8 + gridLayout1.rowSpacing*8
    height: angleFrame1.height*8 + gridLayout1.columnSpacing *8
    property alias layout: gridLayout1

    GridLayout {
        id: gridLayout1
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        rows: 0
        rowSpacing: 2
        columns: 8
        columnSpacing: 2
        anchors.fill: parent

        AngleFrame {
            id: angleFrame2
        }

        AngleFrame {
            id: angleFrame1
        }

        AngleFrame {
            id: angleFrame3
        }

        AngleFrame {
            id: angleFrame4
        }

        AngleFrame {
            id: angleFrame5
        }

        AngleFrame {
            id: angleFrame6
        }

        AngleFrame {
            id: angleFrame7
        }

        AngleFrame {
            id: angleFrame8
        }

        AngleFrame {
            id: angleFrame9
        }

        AngleFrame {
            id: angleFrame10
        }

        AngleFrame {
            id: angleFrame11
        }

        AngleFrame {
            id: angleFrame12
        }

        AngleFrame {
            id: angleFrame13
        }

        AngleFrame {
            id: angleFrame14
        }

        AngleFrame {
            id: angleFrame15
        }

        AngleFrame {
            id: angleFrame16
        }

        AngleFrame {
            id: angleFrame17
        }

        AngleFrame {
            id: angleFrame18
        }

        AngleFrame {
            id: angleFrame19
        }

        AngleFrame {
            id: angleFrame20
        }

        AngleFrame {
            id: angleFrame21
        }

        AngleFrame {
            id: angleFrame22
        }

        AngleFrame {
            id: angleFrame23
        }

        AngleFrame {
            id: angleFrame24
        }

        AngleFrame {
            id: angleFrame25
        }

        AngleFrame {
            id: angleFrame26
        }

        AngleFrame {
            id: angleFrame27
        }

        AngleFrame {
            id: angleFrame28
        }

        AngleFrame {
            id: angleFrame29
        }

        AngleFrame {
            id: angleFrame30
        }

        AngleFrame {
            id: angleFrame31
        }

        AngleFrame {
            id: angleFrame32
        }

        AngleFrame {
            id: angleFrame33
        }

        AngleFrame {
            id: angleFrame34
        }

        AngleFrame {
            id: angleFrame35
        }

        AngleFrame {
            id: angleFrame36
        }

        AngleFrame {
            id: angleFrame37
        }

        AngleFrame {
            id: angleFrame38
        }

        AngleFrame {
            id: angleFrame39
        }

        AngleFrame {
            id: angleFrame40
        }

        AngleFrame {
            id: angleFrame41
        }

        AngleFrame {
            id: angleFrame42
        }

        AngleFrame {
            id: angleFrame43
        }

        AngleFrame {
            id: angleFrame44
        }

        AngleFrame {
            id: angleFrame45
        }

        AngleFrame {
            id: angleFrame46
        }

        AngleFrame {
            id: angleFrame47
        }

        AngleFrame {
            id: angleFrame48
        }

        AngleFrame {
            id: angleFrame49
        }

        AngleFrame {
            id: angleFrame50
        }

        AngleFrame {
            id: angleFrame51
        }

        AngleFrame {
            id: angleFrame52
        }

        AngleFrame {
            id: angleFrame53
        }

        AngleFrame {
            id: angleFrame54
        }

        AngleFrame {
            id: angleFrame55
        }

        AngleFrame {
            id: angleFrame56
        }

        AngleFrame {
            id: angleFrame57
        }

        AngleFrame {
            id: angleFrame58
        }

        AngleFrame {
            id: angleFrame59
        }

        AngleFrame {
            id: angleFrame60
        }

        AngleFrame {
            id: angleFrame61
        }

        AngleFrame {
            id: angleFrame62
        }

        AngleFrame {
            id: angleFrame63
        }

        AngleFrame {
            id: angleFrame64
        }

    }

    TextInput {
        id: textInput1
        x: -30
        y: -75
        width: 80
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }
}

