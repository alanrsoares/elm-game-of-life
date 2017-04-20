module Components.Grid exposing (..)


import Html exposing (Html, Attribute, div, text)
import Html.Attributes exposing (class)
import Models exposing (Grid, Cell)


mapToDivWithClass : String -> (a -> Html msg) -> List a -> Html msg
mapToDivWithClass cls f xs =
  div [ class cls ] (List.map f xs)


renderCell : Cell -> Html x
renderCell cell =
  div
    [class "grid-tile"]
    []


renderRow : List Cell -> Html x
renderRow = mapToDivWithClass "grid-row" renderCell


renderGrid : List (List Cell) -> Html x
renderGrid = mapToDivWithClass "grid" renderRow


view : Grid -> Html x
view = renderGrid
