module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, Grid, Coords, makeGrid, initialModel)
import Array exposing (Array)


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
            ( model, Cmd.none )

        Toggle ( coords, alive ) ->
            ( { model
                | grid = toggle coords alive model.grid
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
