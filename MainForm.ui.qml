import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import "WoodenUi"
import dev.anglegame 1.0
import QtGraphicalEffects 1.0


Item {
    width: 640
    height: 480
    id : main

    AngleData {
        id : data
    }


    property alias pcBtn : computerBtn
    property alias mpBtn : multiplayerBtn
    property alias settingsBtn : settingsBtn
    property alias angleField : angleField

    property alias mainBtn : mainBtns

    property alias newGameBtn : newGameBtn
    property alias continueBtn : continueBtn

    property alias settingsSaveBtn : settingsSave
    property alias settingsExitBtn : settingsExit
    property alias settingsStep : settingsHSInput.inputText

    property alias messageDlgLabel : messageLabel
    property alias messageDlgBtn : messageBtn
    property alias msgDlg : messageDlg

    property alias unwindBtn : angleFieldUnwindBtn


    property int maxStepCount : 0
    property bool musicEnabled : true
    property bool sonicEnabled : true

    property alias continueDlg : continueDlg

    property int timerMin : 0
    property int timerSecs : 0

    property alias steplbl : stepLbl.lblText


    property alias inputDlgFirstName : name
    property alias inputDlgSecondName : secName
    property alias inputDlgMouseArea : inputMA
    property alias inputDlgFirstChecker : fChecker
    property alias inputDlgSecondChecker : sChecker
    property alias inputDlgFinishBtn : finishBtn

    property alias gameData : data
    Image {
        id: mainBackground
        width: 647
        z: -1
        anchors.rightMargin: -10
        anchors.leftMargin: -10
        anchors.bottomMargin: -10
        anchors.topMargin: -9
        anchors.fill: parent
        source: "image/background.png"


        Item {
            id: menu
            visible: true
            anchors.fill: parent

            Item {
                id: mainBtns
                x: 184
                y: 88
                width: 283
                height: 317
                visible: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                z: 0

                WoodenButton {
                    id: computerBtn
                    y: 81
                    width: 245
                    height: 68
                    visible: true
                    anchors.horizontalCenterOffset: 0
                    textOnLabel: qsTr("Компьютер")
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                WoodenButton {
                    id: multiplayerBtn
                    x: 0
                    y: 155
                    width: 245
                    height: 68
                    visible: true
                    anchors.horizontalCenterOffset: 1
                    textOnLabel: qsTr("Мультиплеер")
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                WoodenButton {
                    id: settingsBtn
                    x: 0
                    y: 229
                    width: 245
                    height: 68
                    visible: true
                    anchors.horizontalCenterOffset: 0
                    textOnLabel: qsTr("Настройки")
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                WoodenText {
                    id: woodenText1
                    x: -8
                    width: 262
                    height: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                    lblSize: 60
                    opacity: 0.5
                    lblText: qsTr("Уголки")
                }
            }

            Item {
                id: continueDlg
                x: 84
                y: 149
                width: 446
                height: 250

                visible: false
                property string dlgText : "Ваша последняя игра не была окончена. Хотите продолжить?"
                property alias newGameBtn : newGameBtn
                property alias continueBtn : continueBtn

                GridLayout {
                    id: gridLayout1
                    anchors.fill: parent
                    opacity: 0

                    WoodenText {
                        id: continueText
                        width: 446
                        height: 150
                        lblSize: 35
                        lblText: continueDlg.dlgText
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.column: 0
                        Layout.row: 0
                    }


                    RowLayout {
                        id: rowLayout2
                        width: 100
                        height: 100
                        opacity: 0


                        WoodenButton {
                            id: newGameBtn
                            width: 217
                            height: 50
                            textOnLabel: "Новая игра"
                        }
                        WoodenButton {
                            id: continueBtn
                            width: 217
                            height: 50
                            textOnLabel: "Продолжить"
                        }
                    }



                }
                anchors.verticalCenterOffset: 9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -19
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                id: inputDlg
                x: 181
                y: 105
                width : name.width + name.height
                height: 134
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                property alias fPlayerName : name.inputText
                property alias sPlayerName : secName.inputText

                property alias firstChecker : fChecker
                property alias secondChecker : sChecker

















                ColumnLayout {
                    id: columnLayout1
                    width: 100
                    height: 100
                    opacity: 0
                    anchors.right: parent.right
                    anchors.left: parent.left

                    Item {
                        id: item1
                        width: 200
                        opacity: 0
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.left: parent.left

                        Image {
                            id: fChecker
                            x: 141
                            y: 0
                            height: name.height
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            anchors.left: name.right
                            anchors.leftMargin: 0
                            source: angleField.fieldFirstPlayerImage
                        }

                        WoodenTextField {
                            id: name
                            x: 0
                            y: 0
                            width: 141
                            height: 43
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            inputText: "Player1"
                        }

                    }

                    Item {
                        id: item2
                        width: 200
                        opacity: 0

                        anchors.top: item1.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left

                        Image {
                            id: sChecker
                            x: 141
                            y: 43
                            height: 43
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            source: angleField.fieldSecondPlayerImage
                            anchors.topMargin: 0
                            anchors.left: secName.right
                        }

                        WoodenTextField {
                            id: secName
                            x: 0
                            y: 43
                            width: 141
                            height: 43
                            anchors.leftMargin: 0
                            inputText: "Player2"
                            anchors.left: parent.left
                        }

                    }


                }

                WoodenButton {
                    id: finishBtn
                    scale: 1
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top : columnLayout1.bottom
                    anchors.topMargin: 10
                    textOnLabel: "Готово"
                }







                MouseArea {
                    id: inputMA
                    width : sChecker.width
                    height: sChecker.height*2
                    anchors.right: parent.right
                    anchors.top : parent.top
                }





            }

            Item {
                id: settingsDlg
                width: 390
                height: 317
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                ColumnLayout {
                    id: settingsLayout
                    height: 52
                    anchors.fill: parent

                    Item {
                        id: settingsTitleItem
                        width: 200
                        height: 50
                        Layout.fillWidth: true

                        WoodenText {
                            id: settingsTitle
                            opacity: 0.7
                            lblSize: 35
                            lblText: "Настройки"
                            anchors.fill: parent
                        }
                    }

                    Item {
                        id: settingsHouseStep
                        width: 200
                        height: 50
                        Layout.fillWidth: true

                        RowLayout {
                            id: settingsHSLayout
                            anchors.fill: parent

                            WoodenText {
                                id: settingsHSLabel
                                height: 50
                                lblSize: 18
                                opacity: 0.7
                                lblText: "Кол-во ходов,за которое необходимо покинуть дом :"
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }

                            WoodenTextField {
                                id: settingsHSInput
                                height: 50
                                inputText: "80"
                                Layout.fillWidth: true
                                Layout.minimumWidth: 10
                                Layout.maximumWidth: 50
                                inputValidator: IntValidator { bottom: 1 ; top: 1000;  }
                            }
                        }
                    }

                    Item {
                        id: settingsMusicItem
                        width: 200
                        height: 50
                        Layout.fillWidth: true
                        RowLayout {
                            id: settingsMusicLayout
                            WoodenText {
                                id: settingsMusicLbl
                                height: 50
                                visible: true
                                lblText: "Музыка "
                                Layout.fillHeight: true
                                opacity: 0.7
                                lblSize: 18
                                Layout.fillWidth: true
                            }

                            CheckBox {
                                id: checkBox1
                                text: qsTr("")
                                activeFocusOnPress: false
                                checked: false
                            }
                            anchors.fill: parent
                        }
                    }

                    Item {
                        id: settingsMusicItem1
                        width: 200
                        height: 50
                        Layout.fillWidth: true
                        RowLayout {
                            id: settingsMusicLayout1
                            WoodenText {
                                id: settingsMusicLbl1
                                height: 50
                                Layout.fillHeight: true
                                lblText: "Музыка "
                                opacity: 0.7
                                lblSize: 18
                                visible: true
                                Layout.fillWidth: true
                            }

                            CheckBox {
                                id: checkBox2
                                text: qsTr("")
                                checked: false
                                activeFocusOnPress: false
                            }
                            anchors.fill: parent
                        }
                    }

                    Item {
                        id: settingsBtnItem
                        width: 200
                        height: 50
                        opacity: 0
                        Layout.fillWidth: true

                        RowLayout {
                            id: rowLayout3
                            anchors.fill: parent
                            opacity: 0

                            WoodenButton {
                                id: settingsSave
                                opacity: 0
                            }

                            WoodenButton {
                                id: settingsExit
                                opacity: 0
                            }
                        }
                    }
                }
            }

        }

        RowLayout {
            id: field
            visible: false
            spacing: 0
            anchors.fill: parent



            Item {
                id: fieldMenuWrapper
                width: 200
                height: 200
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 50
                Layout.maximumWidth: 140

                ColumnLayout {
                    id: fieldMenu
                    anchors.fill: parent

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Layout.minimumWidth: 200



                    WoodenText {
                        id: clockText
                        height: 40
                        width : 100
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        opacity: 0.3
                        lblSize: 30
                        lblText: "Время"
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        Layout.fillWidth: true
                        Layout.minimumWidth: 100
                    }


                    WoodenText {
                        id: clock
                        height: 35
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        opacity: 0.3
                        lblSize: 31
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        lblText: timerMin + ":" + timerSecs
                        anchors.top: clockText.bottom
                        anchors.topMargin: 11
                        Layout.fillWidth: true
                        Layout.margins: 5
                    }




                    WoodenText {
                        id: stepText
                        width: 100
                        height: 40
                        anchors.left: parent.left
                        anchors.rightMargin: 0
                        Layout.minimumWidth: 100
                        anchors.right: parent.right
                        anchors.topMargin: 0
                        lblSize: 30
                        anchors.leftMargin: 10
                        opacity: 0.3
                        Layout.fillWidth: true
                        anchors.top: clock.bottom
                        lblText: "Ход"
                    }


                    Item {
                        id: stepLbls
                        height: 50
                        opacity: 0.3
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: stepText.bottom
                        anchors.topMargin: 0

                        Layout.fillWidth: true
                        Layout.maximumWidth: 90




                        RowLayout {
                            id: rowLayout1
                            height: 50
                            spacing: 0
                            anchors.fill: parent

                            WoodenText {
                                id: stepLbl
                                height: 35
                                opacity: 0.7
                                lblText: "0"
                                lblSize: 30
                                Layout.fillWidth: true
                            }
                        }
                    }



                    WoodenRadioButton {
                        id: angleFieldUnwindBtn
                        z: 5
                        visible: true
                        anchors.top: stepLbls.bottom
                        anchors.topMargin: 50
                        opacity: 1
                        anchors.left: parent.left
                        anchors.leftMargin: -7
                        rotation: 0
                        scale: 3
                    }
                }
            }


            AngleField {
                id: angleField
                anchors.left: fieldMenuWrapper.right
                anchors.leftMargin: 0
                z: 2

                Layout.fillWidth: true
                Layout.maximumWidth: (field.width/6)*5

                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 9
            }

        }
    }

    Item {
        id: messageDlg
        x: 227
        y: 158
        width: 350
        height: 309
        visible: false
        z: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: image1
            z: 1
            anchors.fill: parent
            source: "image/background.png"
        }

        WoodenText {
            id: messageLabel
            z: 1
            anchors.bottom: messageBtn.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottomMargin: 0
            anchors.leftMargin: 16
            anchors.rightMargin: 10
            opacity: 0.6
            lblSize: 35
            lblText: "Игрок NIKITA победил "
        }


        WoodenButton {
            id: messageBtn
            height: 40
            z: 1
            opacity: 0.7
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            textOnLblSize: 32
            textOnLabel: "ок"
            onToggled: messageDlg.visible = false
        }

        RectangularGlow {
            id: effect
            x: 0
            y: 0
            anchors.fill: messageDlg
            glowRadius: 3
            spread: 0.2
            color: "black"
            visible: true
            cornerRadius: 25
        }



    }

    states: [
        State {
            name: "continueDlg"

            PropertyChanges {
                target: computerBtn
                visible: true
            }

            PropertyChanges {
                target: multiplayerBtn
                visible: true
            }

            PropertyChanges {
                target: settingsBtn
                visible: true
            }

            PropertyChanges {
                target: mainBtns
                z: 0
                visible: false
            }

            PropertyChanges {
                target: mainBackground
                z: 0
            }

            PropertyChanges {
                target: continueDlg
                width: 450
                height: 250
                visible: true
                anchors.verticalCenterOffset: 1
                anchors.horizontalCenterOffset: 0
            }

            PropertyChanges {
                target: menu
                visible: true
            }

            PropertyChanges {
                target: gridLayout1
                rows: 4
                columns: 1
                opacity: 1
            }

            PropertyChanges {
                target: continueText
                anchors.leftMargin: 0
                anchors.bottomMargin: 104
                anchors.topMargin: 0
            }

            PropertyChanges {
                target: rowLayout2
                opacity: 1
            }
        },
        State {
            name: "field"
            PropertyChanges {
                target: computerBtn
                visible: true
            }

            PropertyChanges {
                target: multiplayerBtn
                visible: true
            }

            PropertyChanges {
                target: settingsBtn
                visible: true
            }

            PropertyChanges {
                target: mainBtns
                z: 0
                visible: false
            }

            PropertyChanges {
                target: mainBackground
                z: 0
            }

            PropertyChanges {
                target: continueDlg
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: 1
                visible: false
            }

            PropertyChanges {
                target: field
                visible: true
            }

            PropertyChanges {
                target: angleFieldUnwindBtn
                enabled: true
            }
        },
        State {
            name: "inputDlg"

            PropertyChanges {
                target: inputDlg
                visible: true
            }

            PropertyChanges {
                target: mainBtns
                visible: false
            }

            PropertyChanges {
                target: item1
                anchors.topMargin: 0
                anchors.bottomMargin: -116
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                opacity: 1
            }

            PropertyChanges {
                target: item2
                visible: true
                anchors.bottomMargin: -116
                opacity: 1
            }

            PropertyChanges {
                target: inputMA
                x: 162
                width: 43
                anchors.rightMargin: 0
                anchors.leftMargin: 84
            }

            PropertyChanges {
                target: finishBtn
                anchors.topMargin: 5
            }

            PropertyChanges {
                target: columnLayout1
                width: 184
                height: 84
                spacing: 6
                anchors.topMargin: 0
                anchors.rightMargin: 0
                opacity: 1
            }
        },
        State {
            name: "settingsDlg"

            PropertyChanges {
                target: mainBtns
                visible: false
            }

            PropertyChanges {
                target: settingsDlg
                visible: true
            }

            PropertyChanges {
                target: settingsMusicLbl1
                lblText: "Звуки"
            }

            PropertyChanges {
                target: settingsBtnItem
                height: 50
                opacity: 1
            }

            PropertyChanges {
                target: rowLayout3
                opacity: 1
            }

            PropertyChanges {
                target: settingsSave
                textOnLblSize: 20
                textOnLabel: "Сохранить и выйти"
                opacity: 1
            }

            PropertyChanges {
                target: settingsExit
                textOnLabel: "Забыть и выйти"
                textOnLblSize: 20
                opacity: 1
            }

            PropertyChanges {
                target: settingsHSInput
                inputText: "40"
            }

            PropertyChanges {
                target: settingsMusicItem
                visible: false
            }

            PropertyChanges {
                target: settingsMusicItem1
                visible: false
            }
        }
    ]
    
}
