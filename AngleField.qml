import QtQuick 2.4
import QtQuick.Layouts 1.1

AngleFieldForm {

    property string fieldFirstColor : "#FFFFFF"
    property string fieldSecondColor : "#5c5858"
    property string defaultImage : "qrc:/image/checker.png"

    property string fieldFirstPlayerColor : "#0000FF"
    property string fieldFirstPlayerImage : "qrc:/image/checker.png"
    property int    firstPlayerId : 1

    property string fieldSecondPlayerColor : "#ff0000"
    property string fieldSecondPlayerImage : "qrc:/image/checker.png"
    property int    secondPlayerId : 2


    property variant houseData : 2

    AngleAI{
        id : angleAi
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
           console.log( angleAi.estimateField(createMatrix(),firstPlayerId,secondPlayerId,houseData) )
        }
    }


    Component.onCompleted: {
        updateBackground()
        resetFigure()
        var data = [];
        data[firstPlayerId] = {ang : {x : 0 , y : 0} , mid : {x:3 , y : 3} }
        data[secondPlayerId] = {ang : {x : 7 , y : 7} , mid : {x:4 , y : 4} }
        console.log('get : ' + angleAi.estimateField(createMatrix(),firstPlayerId,secondPlayerId,data)  )
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
                    item.showImage()
                    item.isEmpty = false
                    item.ownerId = firstPlayerId
               }else if(i>=4 && j >= 4 )
               {

                   item.setBackground(fieldSecondPlayerColor)
                   item.setImage(fieldSecondPlayerImage)
                   item.showImage()
                   item.isEmpty = false
                   item.ownerId = secondPlayerId
               }else
                   item.ownerId = 0
           }
        }
    }


    function getFrame(x,y)
    {
        var test = layout.children[x*8 + y];
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
                matr[i][j] = getFrame(i,j).ownerId
            }
        }
        return matr
    }




}

