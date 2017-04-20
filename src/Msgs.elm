module Msgs exposing (..)


type Msg
    = NoOp
    | Start
    | Stop
    | Tick
    | Toggle ( Int, Int )
    | Reset
    | Random
