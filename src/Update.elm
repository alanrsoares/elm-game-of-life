module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)


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

        Toggle ( x, y ) ->
            ( model, Cmd.none )

        Reset ->
            ( model, Cmd.none )

        Random ->
            ( model, Cmd.none )
