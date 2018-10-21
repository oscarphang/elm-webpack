module App exposing (main)

import Browser exposing (..)
import State exposing (..)
import Type exposing (..)
import View exposing (view)


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
