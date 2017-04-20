module Models exposing (..)


grid : Int -> Grid
grid length =
    let
        range =
            List.range 0 length
    in
        range
            |> List.map
                (\x ->
                    range
                        |> List.map
                            (\y ->
                                Cell x y Dead
                            )
                )


type alias Model =
    { grid : Grid
    , gridControls : String
    }


initialModel : Model
initialModel =
    { grid = grid 30
    , gridControls = ""
    }


type CellState
    = Dead
    | Alive


type alias Cell =
    { x : Int
    , y : Int
    , state : CellState
    }


type alias Grid =
    List (List Cell)
