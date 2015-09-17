import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id : mainApp
    title: qsTr("Уголки")
    width: 640
    height: 480
    visible: true

    property bool isPc : true
    property int step : 0
    property int maxStepCount : mainForm.gameData.maxStepCount

    onClosing: {

        if(mainForm.state === "field")
        {
            saveFieldData()
        }

    }

    MainForm {
        id : mainForm
        anchors.fill: parent
        pcBtn.onToggled: {
            isPc = true
            if(gameData.pcAvailable){
                continueDlg.dlgText = "Последняя одиночная игра игрока " + gameData.pcPlayerName + " не была окончена. Продолжить её?"
                mainForm.state = "continueDlg"
            }else{
                inputDlgSecondChecker.visible = false
                inputDlgSecondName.visible = false
                inputDlgFirstName.inputText = gameData.pcPlayerName
                mainForm.state = "inputDlg"
            }
        }
        mpBtn.onToggled: {
            isPc = false
            if(gameData.mpAvailable){
                continueDlg.dlgText = "Последняя игра между игроком " + gameData.mpFirstPlayerName + " и "
                        + gameData.mpSecondPlayerName +  " не была окончена. Хотите продолжить её?"
                mainForm.state = "continueDlg"
            }else{
                inputDlgFirstName.inputText = gameData.mpFirstPlayerName
                inputDlgSecondName.inputText = gameData.mpSecondPlayerName
                mainForm.state = "inputDlg"
            }

        }


        settingsBtn.onToggled: {
            settingsStep = mainForm.gameData.maxStepCount
            mainForm.state = "settingsDlg"
        }
        settingsSaveBtn.onToggled: {
            console.log('save')
            mainForm.gameData.maxStepCount = settingsStep
            mainForm.state = ""
        }

        settingsExitBtn.onToggled: {
            settingsStep  = mainForm.gameData.maxStepCount
            mainForm.state = ""

        }

        unwindBtn.onToggled: {
            saveFieldData()
            mainForm.state = ""
            pcBtn.visible = true
            mpBtn.visible = true
            settingsBtn.visible = true
            mainForm.angleField.clearField()
        }




        inputDlgMouseArea.onClicked: {
            var buf = String(inputDlgFirstChecker.source)
            inputDlgFirstChecker.source = inputDlgSecondChecker.source
            inputDlgSecondChecker.source = buf
        }

        inputDlgFinishBtn.onToggled: {
            if(isPc)
            {

                gameData.pcPlayerName = inputDlgFirstName.inputText
                if(inputDlgFirstChecker.source == angleField.fieldFirstPlayerImage){
                    angleField.firstPlayerId  = 2
                    angleField.secondPlayerId =  -2
                }else{
                    angleField.firstPlayerId  =  -2
                    angleField.secondPlayerId = 2
                }
                angleField.currentPlayerId = ( gameData.pcIsFPActive ? angleField.firstPlayerId : angleField.secondPlayerId)
                gameData.pcAvailable = true
                console.log('pc true')
            }else{
                console.log('Mp true')
                gameData.mpAvailable = true
                angleField.firstPlayerId  = 1
                angleField.secondPlayerId = 2
                angleField.currentPlayerId = 1
                if(inputDlgFirstChecker.source == angleField.fieldFirstPlayerImage){
                    gameData.mpFirstPlayerName = inputDlgFirstName.inputText
                    gameData.mpSecondPlayerName = inputDlgSecondName.inputText
                }else{
                    gameData.mpFirstPlayerName = inputDlgSecondName.inputText
                    gameData.mpSecondPlayerName = inputDlgFirstName.inputText
                }

            }

            inputDlgSecondName.visible = true
            inputDlgSecondChecker.visible = true

            step = 0
            steplbl = 0
            timerMin = 0
            timerSecs = 0
            angleField.startNewGame()
            mainForm.state  = "field"

        }

        continueBtn.onToggled: {
            if(isPc)
                fieldLoadPc()
            else
                fieldLoadMp()


            mainForm.state = "field"

        }

        newGameBtn.onToggled: {

            if(isPc){
                inputDlgSecondChecker.visible = false
                inputDlgSecondName.visible = false
                inputDlgFirstName.inputText = gameData.pcPlayerName
                mainForm.state = "inputDlg"
            }else{
                inputDlgFirstName.inputText = gameData.mpFirstPlayerName
                inputDlgSecondName.inputText = gameData.mpSecondPlayerName
                mainForm.state = "inputDlg"
            }

        }



        Timer {
            id : timer
            interval: 1000; running: true; repeat: true
            onTriggered: {
                if(mainForm.timerSecs === 60)
                {
                    mainForm.timerMin++
                    mainForm.timerSecs = 0
                }else
                    mainForm.timerSecs++;
            }


        }

        angleField.onStepFinished: {
            if(Math.floor(step/2) === mainApp.maxStepCount)
            {
                var fpPieces = angleField.ai.playerPiecesInHouse(angleField.firstPlayerId,
                                    angleField.firstPlayerId,angleField.matrix,angleField.houseData)
                var spPieces = angleField.ai.playerPiecesInHouse(angleField.secondPlayerId,
                                    angleField.secondPlayerId,angleField.matrix,angleField.houseData)
                if(fpPieces > 0 || spPieces > 0)
                {
                    if(fpPieces > 0 && spPieces <=0)
                    {
                        if(isPc)
                        {
                            if(angleField.secondPlayerId < 0)
                                mainApp.showGameDialog("Компьютер победил")
                            else
                                mainApp.showGameDIalog("Игрок " + mainForm.gameData.pcPlayerName + " победил")
                        }else
                        {
                            mainApp.showGameDialog("Игрок " + mainForm.gameData.mpSecondPlayerName)
                        }
                    }else if(fpPieces <=0 && spPieces > 0){
                        if(isPc)
                        {
                            if(angleField.firstPlayerId < 0)
                                mainApp.showGameDialog("Компьютер победил")
                            else
                                mainApp.showGameDIalog("Игрок " + mainForm.gameData.pcPlayerName + " победил")
                        }else
                        {
                            mainApp.showGameDialog("Игрок " + mainForm.gameData.mpFirstPlayerName)
                        }
                    }else
                        mainApp.showGameDialog('Ничья')

                    if(isPc)
                        mainForm.gameData.pcAvailable = false
                    else
                        mainForm.gameData.mpAvailable = false

                    mainForm.state = ""
                    pcBtn.visible = true
                    mpBtn.visible = true
                    settingsBtn.visible = true
                    angleField.clearField()
                }

            }
            var finishedPlayer = mainForm.angleField.gameFinished()
            if(finishedPlayer > 0 && step > 0)
            {
                console.log('second')
                if(isPc)
                {
                    if(finishedPlayer === 3)
                    {
                        showGameDialog("Ничья")
                    }else if(finishedPlayer === 1 && mainForm.angleField.firstPlayerId < 0
                            || finishedPlayer === 2 && mainForm.angleField.secondPlayerId < 0)
                        showGameDialog("Компьютер победил")
                    else
                        showGameDialog("Игрок " + mainForm.gameData.pcPlayerName + " победил")
                }else{
                    if(finishedPlayer === 3)
                    {
                        showGameDialog("Ничья")
                    }else if(finishedPlayer === 1)
                        showGameDialog("Игрок " + mainForm.gameData.mpFirstPlayerName + " победил")
                    else
                        showGameDialog("Игрок " + mainForm.gameData.mpSecondPlayerName + " победил")

                }


                if(isPc)
                    mainForm.gameData.pcAvailable = false
                else
                    mainForm.gameData.mpAvailable = false


                mainForm.state = ""
                pcBtn.visible = true
                mpBtn.visible = true
                settingsBtn.visible = true

                angleField.clearField()

            }

            step++
            steplbl = Math.floor(step/2)
        }


    }

    function saveFieldData(){
        if(mainForm.angleField.gameFinished() === 0 ){
            mainForm.angleField.removePossibleMoves()
            if(isPc)
            {
                mainForm.gameData.pcField = mainForm.angleField.matrix
                mainForm.gameData.pcAvailable = true
                mainForm.gameData.pcTime =  mainForm.timerMin*60 + mainForm.timerSecs
                mainForm.gameData.pcStep = step
                mainForm.gameData.pcIsFpSide = (mainForm.angleField.firstPlayerId > 0)
                mainForm.gameData.pcCurrentPlayer = mainForm.angleField.currentPlayerId
            }
            else{
                mainForm.gameData.mpField = mainForm.angleField.matrix
                mainForm.gameData.mpAvailable = true
                mainForm.gameData.mpTime =  mainForm.timerMin*60 + mainForm.timerSecs
                mainForm.gameData.mpStep = step
                mainForm.gameData.mpCurrentPlayer = mainForm.angleField.currentPlayerId
            }


        }else{

            if(isPc)
                mainForm.gameData.pcAvailable = false
            else
                mainForm.gameData.mpAvailable = false
        }

    }


    function fieldLoadPc(){
        var field = mainForm.angleField
        if(mainForm.gameData.pcIsFpSide){
            field.firstPlayerId = 2
            field.secondPlayerId = -2
        }else{
            field.firstPlayerId = -2
            field.secondPlayerId = 2
        }

        mainForm.timerMin = Math.floor(mainForm.gameData.pcTime/60)
        mainForm.timerSecs = Math.floor(mainForm.gameData.pcTime % 60)
        step = mainForm.gameData.pcStep
        mainForm.steplbl = Math.floor(step/2)

        mainForm.angleField.currentPlayerId = mainForm.gameData.pcCurrentPlayer

        field.loadMatrix(mainForm.gameData.pcField)
    }

    function fieldLoadMp(){
        var field = mainForm.angleField
        field.firstPlayerId = 1
        field.secondPlayerId = 2


        mainForm.timerMin = Math.floor(mainForm.gameData.mpTime/60)
        mainForm.timerSecs = Math.floor(mainForm.gameData.mpTime % 60)

        step = mainForm.gameData.mpStep
        mainForm.steplbl = Math.floor(step/2)

        mainForm.angleField.currentPlayerId = mainForm.gameData.mpCurrentPlayer

        field.loadMatrix(mainForm.gameData.mpField)

    }


    function showGameDialog(message)
    {

        mainForm.messageDlgLabel.lblText = message

        mainForm.msgDlg.visible = true


    }

    function showMain(){

    }



}








