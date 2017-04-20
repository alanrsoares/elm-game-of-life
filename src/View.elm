module View exposing (..)

import Html exposing (Html, div, text, span, h1)
import Html.Attributes exposing (class)
import Models exposing (Model)
import Msgs exposing (Msg)
import Components.Grid
import Components.GridControls


view : Model -> Html Msg
view model =
    page model


page : Model -> Html Msg
page model =
  div
    [ class "container" ]
    [ div
        [class "page-header text-center"]
        [ h1
            []
            [ span
                [ class "text-muted" ]
                [ text "Conway's" ]
            , text " Game of Life"
            ]
        ]
      , Components.GridControls.view model.gridControls
      , Components.Grid.view model.grid
    ]
