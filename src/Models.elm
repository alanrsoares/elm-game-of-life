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
    case key of
        (-1) ->
            size - 1

        size ->
            0


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


willLive : Bool -> Int -> Bool
willLive alive neighbours =
    if alive then
        2 <= neighbours && neighbours <= 3
    else
        3 == neighbours


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
            |> List.filter identity
            |> List.length
