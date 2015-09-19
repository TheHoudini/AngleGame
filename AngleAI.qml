import QtQuick 2.0

QtObject {


    property int criteria_distance_to_house_grade: 3

    property double criteria_distance_to_house  : 1000000.0
    property int house_punishment_pieces_in_house_turn_grade : 3
    property double criteria_peices_in_house  : 150000.0
    property double criteria_house_punishment : 0.000000003

    // SUPER KOSTIL 228
    property variant lastStep : 0


    function getEmptySlotInHouse(playerId,field,houseData)
    {
        var houseItem = houseData[playerId]
        var firstPoint
        var secondPoint
        if(houseItem.ang.x > houseItem.mid.x)
        {
            firstPoint = houseItem.mid
            secondPoint = houseItem.ang
        }else{
            firstPoint = houseItem.ang
            secondPoint = houseItem.mid
        }
        var arr = []
        for(var i = firstPoint.y ; i<= secondPoint.y ; i++)
        {
            for(var j = firstPoint.x ; j <= secondPoint.x ; j++)
            {
                if(field[i][j] === 0)
                {
                    arr.push({x: i , y  : j})
                }
            }
        }
        return arr

    }


    function calculateBestMove(field,playerId,opponentId,houseData)
    {
        var moves = getAllPossibleMoves(field,playerId)
        var topBorder = +10000000000000
        var alpha =     -10000000000000
        var bestMove = {}

        var pieces = piecesOutsideHouse(playerId,opponentId,field,houseData)
        var slots = getEmptySlotInHouse(opponentId,field,houseData)
        for(var i = 0 ; i < moves.length ; i++)
        {

            var move = moves[i]
            if(pieces.length <= 2)
            {
                var isValidMove = false
                for(var j = 0 ; j < pieces.length ; j++)
                {
                    var piece = pieces[j]
                    if(move.from.x === piece.x && move.from.y === piece.y)
                        isValidMove = true

                }
                if(!isValidMove)
                    continue
                else
                    for(var z = 0 ; z < slots.length ; z++)
                    {
                        if(move.to.x === slots[z].x && move.to.y === slots[z].y)
                        {
                            lastStep = move.from
                            return move
                        }
                    }
            }




            var betta = estimateMoveValue(field,moves[i],playerId,opponentId,houseData)

            if(betta > alpha )
            {
                if(lastStep !== 0 && move.to.x === lastStep.x && move.to.y === lastStep.y)
                    continue

                alpha = betta
                bestMove = move
            }
            if(betta > topBorder)
                break
        }
        lastStep = bestMove.from
        return bestMove
    }


    function estimateMoveValue(field,move,playerId,opponentId,houseData,depth,alpha,betta)
    {
        if(depth === undefined)
        {
            depth = 0
            alpha =  -10000000000000
            betta =  +10000000000000
        }
        applyMoveToField(move,field)
        if(depth === 0 )
        {

            var value = estimateField(field,playerId,opponentId,houseData)
            resetMoveFromField(move,field)
            return value
        }


        var moves = getAllPossibleMoves(field,playerId)

        for(var i = 0 ; i < moves.length ; i++)
        {
            var gamma = estimateMoveValue(field,moves[i],playerId,opponentId,houseData,depth-1,alpha,betta)
            if(gamma > alpha)
                alpha = gamma

        }

        resetMoveFromField(move,field)
        return alpha

    }

    function printField(field)
    {
        for(var i = 0 ; i < field.length ; i++)
        {
            print(field[i])
        }
    }

    function piecesOutsideHouse(playerId,opponentId,field,houseData)
    {
        var houseItem = houseData[opponentId]
        var firstPoint
        var secondPoint
        if(houseItem.ang.x > houseItem.mid.x)
        {
            firstPoint = houseItem.mid
            secondPoint = houseItem.ang
        }else{
            firstPoint = houseItem.ang
            secondPoint = houseItem.mid
        }
        var result = []
        for(var i = 0 ; i< field.length ; i++)
        {
            for(var j = 0 ; j < field.length ; j++)
            {
                if(field[i][j] !== playerId)
                {
                    continue
                }

                if( !(firstPoint.x <= i && firstPoint.y <= j && secondPoint.x >= i && secondPoint.y >= j) )
                {
                    result.push( {x:i , y : j} )
                }
            }
        }
        return result

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
                    if( piecesOutsideHouse(playerId,opponentId,field,houseData).length <= 2)
                    {
                        var point = getEmptySlotInHouse(opponentId,field,houseData)[0]
                        if(point === undefined)
                            return 100000000000000000000000000000000
                        houseRange -= distanceToHouse(i,j,point  )
                    }
                    else
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
            piecesInOpponentHouse += 10000000000000000

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
        if(x <= 5 && field[x+2][y] === 0  && field[x+1][y] !== 0  )
        {
            result.push( {from : basic , to : {x:x+2 , y : y} })
        }
        // check top
        if(y <= 5 && field[x][y+2] === 0 && field[x][y+1] !== 0 )
        {
            result.push( {from : basic , to : {x:x , y : y+2} } )
        }
        // check left
        if(x >= 2 && field[x-2][y] === 0  && field[x-1][y] !== 0 )
        {
            result.push( {from : basic , to : {x:x-2 , y : y} } )
        }
        // check bot
        if(y >= 2 && field[x][y-2] === 0  && field[x][y-1] !== 0 )
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

    function playerPiecesInHouse(playerId,housePlayerId,field,houseData)
    {
        var firstPoint
        var secondPoint
        if(playerId === firstPlayerId)
        {
            firstPoint = houseData[housePlayerId].ang
            secondPoint = houseData[housePlayerId].mid
        }else
        {
            firstPoint = houseData[housePlayerId].mid
            secondPoint = houseData[housePlayerId].ang
        }

        var count = 0
        for(var i = firstPoint.x ; i <= secondPoint.x ; i++)
        {
            for(var j = firstPoint.y ; j <= secondPoint.y ; j++)
            {
                if(field[i][j] === playerId)
                        count++
            }

        }
        console.log('return :' + count)
        return count
    }

}

