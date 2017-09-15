module Models exposing (..)

import Array exposing (Array)


type alias GridControls =
    { autoPlay : Bool
    }


type alias Model =
    { grid : Grid
    , gridControls : GridControls
    }


initialModel : Model
initialModel =
    { grid = makeGrid 30
    , gridControls =
        { autoPlay = False
        }
    }



-- Grid


type alias Grid =
    Array (Array Bool)


type alias Coords =
    ( Int, Int )


makeGrid : Int -> Grid
makeGrid length =
    let
        r =
            Array.initialize length identity

        mapR f =
            Array.map f r
    in
        mapR (\x -> mapR (\y -> False))
