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
    property string fieldSecondPlayerImage : "qrc:/image/checker.png"
    property int    secondPlayerId : 2

    property int tempItemId : -1
    property variant currentItem : 0

    property int    currentPlayerId : secondPlayerId



    property variant houseData : []

    AngleAI{
        id : angleAi
    }


    signal stepFinished

    onStepFinished: {
        currentPlayerId = currentPlayerId == firstPlayerId ? secondPlayerId : firstPlayerId
        if(currentPlayerId < 0)
            doBestMove()

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(currentPlayerId < 0 )
                return

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
        resetFigure()
        var data = [];
        data[firstPlayerId] = {ang : {x : 0 , y : 0} , mid : {x:3 , y : 3} }
        data[secondPlayerId] = {ang : {x : 7 , y : 7} , mid : {x:4 , y : 4} }
        houseData = data

       // doBestMove()
    }


    function doBestMove()
    {
        var opponent = currentPlayerId === secondPlayerId ? firstPlayerId : secondPlayerId
        move(angleAi.calculateBestMove(createMatrix(),currentPlayerId , opponent,houseData     ))
        stepFinished()
    }


    function removePossibleMoves(x,y){
        var moves = angleAi.getPossibleMoves(createMatrix(),x,y)
        for(var i = 0 ; i < moves.length ; i++)
        {

            var item = getFrame( moves[i].to.x , moves[i].to.y )
            item.setBackground( (moves[i].to.x +moves[i].to.y) % 2 ? fieldFirstColor : fieldSecondColor )
            item.ownerId = 0
            item.setImage('')


        }
    }

    function drawPossibleMoves(x,y)
    {
        var moves = angleAi.getPossibleMoves(createMatrix(),x,y)
        for(var i = 0 ; i < moves.length ; i++)
        {
            var item = getFrame( moves[i].to.x , moves[i].to.y )
            item.setBackground('#E51BE5')
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
        item.setBackground(currentPlayerId == firstPlayerId ? fieldFirstPlayerColor : fieldSecondPlayerColor)
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
                    item.setBackground(fieldFirstPlayerColor)
                    item.setImage(fieldFirstPlayerImage)
                    item.isEmpty = false
                    item.ownerId = firstPlayerId
               }else if(i>=4 && j >= 4 )
               {

                   item.setBackground(fieldSecondPlayerColor)
                   item.setImage(fieldSecondPlayerImage)
                   item.isEmpty = false
                   item.ownerId = secondPlayerId
               }else
                   item.ownerId = 0
           }
        }
    }


    function getFrame(x,y)
    {
        var test = layout.children[x + y*8];
        return test;
    }




    function createMatrix()
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
        return matr
    }




}

