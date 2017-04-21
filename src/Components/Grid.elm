module Components.Grid exposing (..)

import Html exposing (Html, Attribute, div, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Models exposing (Grid)
import Array exposing (Array)
import Msgs exposing (Msg)


mapToDivWithClass : String -> (a -> Html msg) -> Array a -> Html msg
mapToDivWithClass cls f xs =
    div [ class cls ] ((Array.map f xs) |> Array.toList)


cellStyle : Bool -> List ( String, String )
cellStyle alive =
    if alive then
        [ ( "background-color", "#FFF" ) ]
    else
        []


renderCell : Int -> Int -> Bool -> Html Msg
renderCell y x alive =
    div
        [ class "grid-tile"
        , style (cellStyle alive)
        , onClick (Msgs.Toggle ( ( y, x ), alive ))
        ]
        []


mapArrayToLlist : (Int -> a -> b) -> Array a -> List b
mapArrayToLlist f xs =
    Array.indexedMap f xs
        |> Array.toList


renderRows : Int -> Array Bool -> Html Msg
renderRows y row =
    div
        [ class "grid-row" ]
        (row
            |> mapArrayToLlist (renderCell y)
        )


view : Grid -> Html Msg
view grid =
    div
        [ class "grid" ]
        (grid
            |> mapArrayToLlist renderRows
        )
