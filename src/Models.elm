module Models exposing (..)

import Array exposing (Array)


type alias Model =
    { grid : Grid
    , gridControls : String
    }


initialModel : Model
initialModel =
    { grid = makeGrid 30
    , gridControls = ""
    }



-- Grid


type alias Grid =
    Array (Array Bool)


type alias Coords =
    ( Int, Int )


makeGrid : Int -> Grid
makeGrid length =
    let
        r =
            Array.initialize length identity

        mapR f =
            Array.map f r
    in
        mapR (\x -> mapR (\y -> False))



-- Game


newKey : Int -> Int -> Int
newKey size key =
    if key == -1 then
        size - 1
    else if key == size then
        0
    else
        key


newCoords : Int -> Coords -> Coords
newCoords size ( y, x ) =
    ( (newKey size y)
    , (newKey size x)
    )


remove : a -> List a -> List a
remove x xs =
    xs |> List.filter (\x_ -> x_ /= x)


combinePositions : Coords -> List Coords
combinePositions ( y, x ) =
    let
        offset =
            [ -1, 0, 1 ]
    in
        offset
            |> List.concatMap
                (\y_ ->
                    offset
                        |> List.map
                            (\x_ -> ( y + y_, x + x_ ))
                )
            |> remove ( y, x )


getIn : Grid -> Coords -> Bool
getIn grid ( y, x ) =
    Array.get y grid
        |> Maybe.withDefault (Array.fromList [])
        |> Array.get x
        |> Maybe.withDefault False


countNeighbours : Grid -> Coords -> Int
countNeighbours grid ( y, x ) =
    let
        s =
            Array.length grid
    in
        combinePositions ( y, x )
            |> List.map
                (\p ->
                    getIn grid (newCoords s p)
                )
            |> List.filter (\x -> x == True)
            |> List.length


willLive : Bool -> Int -> Bool
willLive alive neighbours =
    if alive then
        2 <= neighbours && neighbours <= 3
    else
        3 == neighbours


nextGeneration : Grid -> Grid
nextGeneration grid =
    grid
        |> Array.indexedMap
            (\y row ->
                row
                    |> Array.indexedMap
                        (\x cell ->
                            willLive cell (countNeighbours grid ( y, x ))
                        )
            )
