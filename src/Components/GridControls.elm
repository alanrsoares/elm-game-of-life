module Components.GridControls exposing (..)

import Html exposing (Html, div, text, button, label, input, i)
import Html.Attributes exposing (class, style, type_, id, value, checked)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models


getIconClass autoPlay =
    "fa fa-"
        ++ if autoPlay then
            "pause"
           else
            "play" ++ " fa-lg"


view : Models.GridControls -> Html Msg
view props =
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
                [ class "btn btn-default"
                , onClick Msgs.Tick
                ]
                [ i [ class "fa fa-fast-forward fa-lg" ] []
                , text " NEXT"
                ]
            , button
                [ class "btn btn-default"
                , onClick Msgs.ToggleAutoPlay
                ]
                [ i [ class (getIconClass props.autoPlay) ]
                    []
                , input
                    [ type_ "checkbox"
                    , checked props.autoPlay
                    , id ""
                    , value "on"
                    , style [ ( "display", "none" ) ]
                    ]
                    []
                , text " AUTO"
                ]
            ]
        ]
