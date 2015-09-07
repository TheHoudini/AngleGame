import QtQuick 2.0

QtObject {


    property int criteria_distance_to_house_grade: 3

    property double criteria_distance_to_house  : 100.0
    property int house_punishment_pieces_in_house_turn_grade : 3
    property double criteria_peices_in_house  : 150000.0
    property double criteria_house_punishment : 0.000000003



    function estimateField(field,playerId,opponentId,houseData)
    {
        var value = 0

        var fieldSize = field.length
        var fieldMiddle = fieldSize / 2

        var houseRange = 0;
        var housePunishment = 0;


        var piecesInOpponentHouse = 0
        var piecesInOwnHouse = 0

        for(var i = 0 ; i < fieldSize ; i ++)
        {
            for(var j = 0 ; j < fieldSize ; j ++)
            {
                if(field[i][j] === playerId)
                {
                    houseRange -= distanceToHouse(i,j, houseData[opponentId].ang );
                    if(isInHouse(i,j,opponentId,houseData))
                    {
                        piecesInOpponentHouse++
                    }
                    else if(isInHouse(i,j,playerId,houseData))
                    {
                        piecesInOwnHouse++
                    }

                }
            }
        }


        var grade = criteria_distance_to_house_grade;
        houseRange = Math.pow(houseRange , grade)

        // check win
        if(piecesInOpponentHouse === (Math.pow(field.length/2,2)) )
            piecesInOpponentHouse += 1000000000

        value += houseRange * criteria_distance_to_house
        grade = house_punishment_pieces_in_house_turn_grade
        housePunishment -= piecesInOwnHouse * Math.pow( 40, grade) + value * 40 * 40;


        value += piecesInOpponentHouse * criteria_peices_in_house;
        value += housePunishment * criteria_house_punishment;

        return value;

    }

    function getPossibleMoves(field,x,y,resultArray)
    {

        // if arr is empty ,create array
        resultArray = resultArray || [];
        var checked = resultArray.length
        mergeArray(resultArray,checkJoined(field,x,y))
        mergeArray(resultArray,checkJump(field,x,y))


        for(var i = checked ; i < resultArray.length ; i++)
        {
            getPossibleMoves(field,resultArray[i][0],resultArray[i][0],resultArray)
        }


        return resultArray

    }


    function getAllPossibleMoves(field,playerId)
    {
        var resultArray = []
        for(var i = 0 ; i < 8 ; i++)
        {
            for(var j = 0 ; j < 8 ; j++)
            {
                if(field[i][j] === playerId)
                {
                    mergeArray(resultArray,getPossibleMoves(field,i,j))
                }
            }
        }
        return resultArray
    }


    function checkJoined(field,x,y)
    {
        var result = []

        var from  = { x : x , y : y}
        // check right
        if(x < 7 && field[x+1][y] === 0)
        {
            result.push( {from : from , to : {x:x+1 , y : y} } )
        }

        // check top
        if(y < 7 && field[x][y+1] === 0)
        {
            result.push( {from : from , to : {x:x , y : y+1} })
        }
        // check left
        if(x > 0 && field[x-1][y] === 0)
        {
            result.push( {from : from , to : {x:x-1 , y : y} } )
        }
        // check bot
        if(y > 0 && field[x][y-1] === 0)
        {
            result.push( {from : from , to : {x:x , y : y-1} } )
        }

        return result;
    }

    function checkJump(field,x,y)
    {

        var result = []
        var from  = { x : x , y : y}
        // check right
        if(x<5 && field[x+2][y] === 0  && field[x+1][y] !== 0  )
        {
            result.push( {from : from , to : {x:x+2 , y : y} })
        }
        // check top
        if(y < 5 && field[x][y+2] === 0 && field[x][y+1] !== 0 )
        {
            result.push( {from : from , to : {x:x , y : y+2} } )
        }
        // check left
        if(x > 2 && field[x-2][y] === 0  && field[x-1][y] !== 0 )
        {
            result.push( {from : from , to : {x:x-2 , y : y} } )
        }
        // check bot
        if(y > 2 && field[x][y-2] === 0  && field[x][y-1] !== 0 )
        {
            result.push( {from : from , to : {x:x , y : y-2} } )
        }

        return result;
    }


    // concat 2 arrays(using push)
    // using instead of .concat for save array structure
    function mergeArray(arr1,arr2)
    {
        for(var i =0;i<arr2.length ; i++)
        {
            var isNew = true
            for(var j = 0; j < arr1.length; j++)
            {
                if(arr1[j] === arr2[i])
                {
                    isNew = false
                    break
                }
            }
            if(isNew)
                arr1.push(arr2[i])
        }
    }




    function isInHouse(x,y,playerId,houseData)
    {
        if( houseData[playerId].ang.x <= x && houseData[playerId].ang.y <= y
                && houseData[playerId].mid.x >= x && houseData[playerId].mid.y >= y )
            return true;
        return false;
    }

    function distanceToHouse(x,y,houseItem)
    {
        return distance(x,y,houseItem.x,houseItem.y)
    }

    function distance(i,j,k,l)
    {
        return Math.sqrt( Math.pow(k - i, 2) + Math.pow(l - j, 2)  );
    }

}

