module Components.GridControls exposing (..)


import Html exposing (Html, div, text, button, label, input, i)
import Html.Attributes exposing (class, style, type_, id, value)
import Models exposing (Grid, Cell)


view : String -> Html x
view grid =
  div
    [ class "grid-controls" ]
    [ div
        [ class "btn-group"
        , style [ ( "margin-bottom", "20px" ) ]
        ]
        [ button
            [ class "btn btn-danger" ]
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
