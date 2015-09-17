import QtQuick 2.4
import QtQuick.Layouts 1.1

AngleFieldForm {

    property string fieldFirstColor : "#FFFFFF"
    property string fieldSecondColor : "#5c5858"
    property string defaultImage : "qrc:/image/checker.png"

    property string fieldFirstPlayerColor : "#0000FF"
    property string fieldFirstPlayerImage : "qrc:/image/checker.png"
    property int    firstPlayerId : -2

    property string fieldSecondPlayerColor : "#ff0000"
    property string fieldSecondPlayerImage : "qrc:/image/blackchecker.png"
    property int    secondPlayerId : 2

    property int tempItemId : -1
    property variant currentItem : 0

    property int    currentPlayerId : firstPlayerId


   property variant matrix : []

    property alias ai : angleAi



    property variant houseData : []

    AngleAI{
        id : angleAi
    }


    signal stepFinished

    onStepFinished: {
        updateMatrix()

        if(gameFinished() > 0)
            return

        currentPlayerId = ( currentPlayerId == firstPlayerId ? secondPlayerId : firstPlayerId)
        if(currentPlayerId < 0)
            doBestMove()

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(currentPlayerId < 0 )
                doBestMove()

            var i = Math.floor( mouseX / getFrame(0,0).width  )
            var j = Math.floor( mouseY / getFrame(0,0).height )

            var item = getFrame(i,j)
            if(item.ownerId === currentPlayerId)
            {
                removePossibleMoves(currentItem.x , currentItem.y)
                drawPossibleMoves(i,j)
                currentItem = {x : i, y : j}

            }else if(item.ownerId === tempItemId)
            {

                removePossibleMoves(currentItem.x , currentItem.y)
                move({from:currentItem , to : {x:i , y : j} })
                currentItem = 0
                stepFinished()
            }



        }
    }


    Component.onCompleted: {
        updateBackground()

       // doBestMove()
    }


    function doBestMove()
    {
        var opponent = currentPlayerId === secondPlayerId ? firstPlayerId : secondPlayerId

        move(angleAi.calculateBestMove(matrix,currentPlayerId , opponent,houseData     ))
        stepFinished()
    }


    function removePossibleMoves(x,y){
        var moves = angleAi.getPossibleMoves(matrix,x,y)
        for(var i = 0 ; i < moves.length ; i++)
        {

            var item = getFrame( moves[i].to.x , moves[i].to.y )
            item.setBackground( (moves[i].to.x +moves[i].to.y) % 2 ? fieldFirstColor : fieldSecondColor )
            item.ownerId = 0
            item.setImage('')
            item.setOpacity(0.9)


        }
    }

    function drawPossibleMoves(x,y)
    {
        var moves = angleAi.getPossibleMoves(matrix,x,y)
        for(var i = 0 ; i < moves.length ; i++)
        {
            var item = getFrame( moves[i].to.x , moves[i].to.y )
            item.setImage( currentPlayerId == firstPlayerId ? fieldFirstPlayerImage : fieldSecondPlayerImage)
            item.setOpacity(0.1)
            item.ownerId = tempItemId

        }

    }


    function move(cord)
    {
        var point = cord.from
        var item = getFrame(point.x,point.y)
        item.setImage('')
        item.setBackground( (point.x + point.y) % 2 ? fieldFirstColor : fieldSecondColor )
        item.ownerId = 0

        point = cord.to
        item = getFrame(point.x,point.y)
        //item.setBackground(currentPlayerId == firstPlayerId ? fieldFirstPlayerColor : fieldSecondPlayerColor)
        item.setImage( currentPlayerId == firstPlayerId ? fieldFirstPlayerImage : fieldSecondPlayerImage)
        item.ownerId = currentPlayerId
    }


    function updateBackground()
    {
        for(var i = 0 ; i < 8 ; i++)
        {
           for(var j = 0 ; j < 8 ; j++)
           {
               layout.children[i*8 + j].setBackground( (i+j) % 2 ? fieldFirstColor : fieldSecondColor  )
           }
        }
    }

    function resetFigure()
    {
        for(var i = 0 ; i < 8 ; i++)
        {
           for(var j = 0 ; j < 8 ; j++)
           {
               var item = layout.children[i*8+j]
               if(i < 4 && j < 4)
               {
                    //item.setBackground(fieldFirstPlayerColor)
                    item.setImage(fieldFirstPlayerImage)
                    item.isEmpty = false
                    item.ownerId = firstPlayerId
               }else if(i>=4 && j >= 4 )
               {

                   //item.setBackground(fieldSecondPlayerColor)
                   item.setImage(fieldSecondPlayerImage)
                   item.isEmpty = false
                   item.ownerId = secondPlayerId
               }else
                   item.ownerId = 0
           }
        }
    }

    function clearField(){
        for(var i = 0 ; i < 8 ; i++)
        {
           for(var j = 0 ; j < 8 ; j++)
           {
               var item = layout.children[i*8+j]
               item.setImage('')
               item.ownerId = 0
           }
        }

    }

    function getFrame(x,y)
    {
        var test = layout.children[x + y*8];
        return test;
    }


    function gameFinished(){
        var mat = matrix

        var fpPieces = 0
        var spPieces = 0


        for(var i = 0 ; i < mat.length ; i++)
        {
             for(var j = 0 ; j < mat.length ; j ++)
             {
                var frame = getFrame(i,j)
                if(frame.ownerId === firstPlayerId && i >=4 && j>=4)
                {
                    fpPieces++
                }else if(frame.ownerId === secondPlayerId && i<4 && j<4)
                {
                    spPieces++
                }

             }
        }

        if(fpPieces === 16 && spPieces === 16)
            return 3
        else if(fpPieces === 16)
            return 1
        else if(spPieces === 16)
            return 2
        else
            return 0

    }


    function updateMatrix()
    {
        var matr = [];
        for(var i = 0 ; i < 8 ; i++)
        {
            matr[i] = [];
            for(var j = 0 ; j < 8 ; j++)
            {
                var id = getFrame(i,j).ownerId
                if(id !== tempItemId)
                    matr[i][j] = id
                else
                    matr[i][j] = 0
            }
        }
        matrix =  matr
    }




    function startNewGame()
    {
        resetFigure()
        currentPlayerId = firstPlayerId

        var data = [];
        data[firstPlayerId] = {ang : {x : 0 , y : 0} , mid : {x:3 , y : 3} }
        data[secondPlayerId] = {ang : {x : 7 , y : 7} , mid : {x:4 , y : 4} }
        houseData = data

        updateMatrix()
        if( currentPlayerId < 0)
            doBestMove()
    }



    function loadMatrix(matrix){
        for(var i = 0 ; i < matrix.length ; i++ )
        {
            for(var j = 0 ; j < matrix.length ; j++)
            {
                var value = matrix[i][j]
                var item  = getFrame(i,j)
                item.ownerId = value
                if( value === firstPlayerId)
                {
                     item.setImage(fieldFirstPlayerImage)
                     item.isEmpty = false
                }else if(value === secondPlayerId )
                {
                    item.setImage(fieldSecondPlayerImage)
                    item.isEmpty = false
                }else
                {
                    item.isEmpty = true
                }

            }


        }
        updateMatrix()


        var data = [];
        data[firstPlayerId] = {ang : {x : 0 , y : 0} , mid : {x:3 , y : 3} }
        data[secondPlayerId] = {ang : {x : 7 , y : 7} , mid : {x:4 , y : 4} }
        houseData = data

        updateMatrix()

        if( currentPlayerId < 0)
            doBestMove()
    }




}

