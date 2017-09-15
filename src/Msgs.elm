module Msgs exposing (..)

import Models exposing (Coords)


type Msg
    = NoOp
    | Start
    | Stop
    | Tick
    | Toggle ( Coords, Bool )
    | Reset
    | Random
    | ToggleAutoPlay
