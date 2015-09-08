import QtQuick 2.0

QtObject {


    property int criteria_distance_to_house_grade: 3

    property double criteria_distance_to_house  : 100.0
    property int house_punishment_pieces_in_house_turn_grade : 3
    property double criteria_peices_in_house  : 150000.0
    property double criteria_house_punishment : 0.000000003





    function calculateBestMove(field,playerId,opponentId,houseData)
    {
        var moves = getAllPossibleMoves(field,playerId)
        var topBorder = +1000000000
        var alpha =     -1000000000

        var bestMove = {}
        for(var i = 0 ; i < moves.length ; i++)
        {
            var betta = estimateMoveValue(field,moves[i],playerId,opponentId,houseData)
            if(betta > alpha)
            {
                alpha = betta
                bestMove = moves[i]
            }
            if(betta > topBorder)
                break
        }
        return bestMove
    }


    function estimateMoveValue(field,move,playerId,opponentId,houseData,depth,alpha,betta)
    {
        if(depth === undefined)
            depth = 3
        alpha = alpha || -1000000000
        betta = betta || +1000000000
        applyMoveToField(move,field)


        if(depth === 0 )
        {
            return estimateField(field,playerId,opponentId,houseData)
        }


        var moves = getAllPossibleMoves(field,playerId)

        for(var i = 0 ; i < moves.length ; i++)
        {
            var gamma = estimateMoveValue(field,moves[i],playerId,opponentId,houseData,depth-1,alpha,betta)
            if(gamma > alpha)
                alpha = betta
            if(gamma > betta)
                break
        }

        resetMoveFromField(move,field)

        return alpha

    }


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



    function getPossibleMoves(field,x,y,resultArray,basic)
    {

        resultArray = resultArray || [];
        if(basic === undefined)
        {
            basic = {x : x , y : y}
            mergeArray(resultArray,checkJoined(field,x,y,basic))
        }

        // if arr is empty ,create array

        var checked = resultArray.length
        mergeArray(resultArray,checkJump(field,x,y,basic))

        for(var i = checked ; i < resultArray.length ; i++)
        {
            getPossibleMoves(field,resultArray[i].to.x,resultArray[i].to.y,resultArray,basic)
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


    function checkJoined(field,x,y,basic)
    {
        var result = []

        // check right
        if(x < 7 && field[x+1][y] === 0)
        {
            result.push( {from : basic , to : {x:x+1 , y : y} } )
        }

        // check top
        if(y < 7 && field[x][y+1] === 0)
        {
            result.push( {from : basic , to : {x:x , y : y+1} })
        }
        // check left
        if(x > 0 && field[x-1][y] === 0)
        {
            result.push( {from : basic , to : {x:x-1 , y : y} } )
        }
        // check bot
        if(y > 0 && field[x][y-1] === 0)
        {
            result.push( {from : basic , to : {x:x , y : y-1} } )
        }

        return result;
    }

    function checkJump(field,x,y,basic)
    {

        var result = []
        var from  = { x : x , y : y}
        // check right
        if(x<5 && field[x+2][y] === 0  && field[x+1][y] !== 0  )
        {
            result.push( {from : basic , to : {x:x+2 , y : y} })
        }
        // check top
        if(y < 5 && field[x][y+2] === 0 && field[x][y+1] !== 0 )
        {
            result.push( {from : basic , to : {x:x , y : y+2} } )
        }
        // check left
        if(x > 2 && field[x-2][y] === 0  && field[x-1][y] !== 0 )
        {
            result.push( {from : basic , to : {x:x-2 , y : y} } )
        }
        // check bot
        if(y > 2 && field[x][y-2] === 0  && field[x][y-1] !== 0 )
        {
            result.push( {from : basic , to : {x:x , y : y-2} } )
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
                if(arr1[j].from.x === arr2[i].from.x && arr1[j].from.y === arr2[i].from.y
                        && arr1[j].to.x === arr2[i].to.x && arr1[j].to.y === arr2[i].to.y  )
                {
                    isNew = false
                    break
                }
            }
            if(isNew)
                arr1.push(arr2[i])
        }

    }

    function mergeArrayUnicalTo(arr1,arr2)
    {

        for(var i =0;i<arr2.length ; i++)
        {
            var isNew = true
            for(var j = 0; j < arr1.length; j++)
            {
                if( arr1[j].to.x === arr2[i].to.x && arr1[j].to.y === arr2[i].to.y  )
                {
                    isNew = false
                    break
                }
            }
            if(isNew)
                arr1.push(arr2[i])
        }

    }


    function applyMoveToField(move,field)
    {
        field[move.to.x][move.to.y] = field[move.from.x][move.from.y]
        field[move.from.x][move.from.y] = 0
    }

    function resetMoveFromField(move,field)
    {
        field[move.from.x][move.from.y] = field[move.to.x][move.to.y]
        field[move.to.x][move.to.y] = 0
    }


    function printArrayWithCords(arr)
    {
        for(var i = 0 ; i <arr.length ; i++)
        {
            print('FROM:' + arr[i].from.x , arr[i].from.y , ' TO :' + arr[i].to.x , arr[i].to.y)
        }
    }

    function printCord(cord)
    {
        print('FROM:' + cord.from.x , cord.from.y , ' TO :' + cord.to.x , cord.to.y)
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

