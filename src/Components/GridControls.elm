module Components.GridControls exposing (..)

import Html exposing (Html, div, text, button, label, input, i)
import Html.Attributes exposing (class, style, type_, id, value)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)


view : String -> Html Msg
view grid =
    div
        [ class "grid-controls" ]
        [ div
            [ class "btn-group grid-controls-buttons" ]
            [ button
                [ class "btn btn-danger"
                , onClick Msgs.Reset
                ]
                [ text "RESET" ]
            , button
                [ class "btn btn-success" ]
                [ text "RANDOMIZE" ]
            , button
                [ class "btn btn-default" ]
                [ i [ class "fa fa-fast-forward fa-lg" ] []
                , text " NEXT"
                ]
            , label
                [ class "btn btn-default" ]
                [ i [ class "fa fa-play fa-lg" ] []
                , input
                    [ type_ "checkbox"
                    , id ""
                    , value "on"
                    , style [ ( "display", "none" ) ]
                    ]
                    []
                , text " AUTO"
                ]
            ]
        ]
