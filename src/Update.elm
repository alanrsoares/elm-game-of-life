module Update exposing (..)

import Array exposing (Array)
import Msgs exposing (Msg(..))
import Models
    exposing
        ( Model
        , Grid
        , GridControls
        , Coords
        , makeGrid
        , initialModel
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Start ->
            ( model, Cmd.none )

        Stop ->
            ( model, Cmd.none )

        Tick ->
            ( { model
                | grid = nextGeneration model.grid
              }
            , Cmd.none
            )

        Toggle ( coords, alive ) ->
            ( { model
                | grid = toggle coords alive model.grid
              }
            , Cmd.none
            )

        ToggleAutoPlay ->
            ( { model
                | gridControls = toggleAutoPlay model.gridControls
              }
            , Cmd.none
            )

        Reset ->
            ( initialModel, Cmd.none )

        Random ->
            ( model, Cmd.none )


getRow : Int -> Grid -> Array Bool
getRow i grid =
    Maybe.withDefault (Array.fromList []) (Array.get i grid)


toggle : Coords -> Bool -> Grid -> Grid
toggle ( y, x ) current g =
    Array.set
        y
        (Array.set x (not current) (getRow y g))
        g


toggleAutoPlay : GridControls -> GridControls
toggleAutoPlay gridControls =
    { gridControls
        | autoPlay = not gridControls.autoPlay
    }


newKey : Int -> Int -> Int
newKey size key =
    if key < 0 then
        size + key
    else if key == size then
        0
    else
        key


removeFromList : a -> List a -> List a
removeFromList x xs =
    xs |> List.filter (\x_ -> x_ /= x)


combinePositions : Coords -> List Coords
combinePositions ( y, x ) =
    let
        offset =
            [ -1, 0, 1 ]

        flatten y_ =
            offset |> List.map (combine y_)

        combine y_ x_ =
            ( y + y_, x + x_ )
    in
        offset
            |> List.concatMap flatten
            |> removeFromList ( y, x )


getIn : Grid -> Coords -> Bool
getIn grid ( y, x ) =
    grid
        |> Array.get y
        |> Maybe.withDefault Array.empty
        |> Array.get x
        |> Maybe.withDefault False


getNewCoords : Int -> Coords -> Coords
getNewCoords size ( y, x ) =
    ( newKey size y
    , newKey size x
    )


countNeighbours : Grid -> Coords -> Int
countNeighbours grid ( y, x ) =
    let
        getPosition p =
            getIn grid (getNewCoords (Array.length grid) p)
    in
        combinePositions ( y, x )
            |> List.map getPosition
            |> List.filter identity
            |> List.length


willLive : Bool -> Int -> Bool
willLive alive neighbourCount =
    if alive then
        2 <= neighbourCount && neighbourCount <= 3
    else
        3 == neighbourCount


nextGeneration : Grid -> Grid
nextGeneration grid =
    let
        mapCell y x cell =
            willLive cell (countNeighbours grid ( y, x ))

        mapRow y =
            Array.indexedMap (mapCell y)
    in
        grid |> Array.indexedMap mapRow
