module Util exposing (getSystemMsg, messageList)

import Dict exposing (..)
import Type exposing (..)


messageList : Dict String String
messageList =
    fromList
        [ ( "HintTypeMore", "Please type more..." )
        , ( "ErrorMsg", "Talent not found or already added." )
        ]


getSystemMsg : String -> String
getSystemMsg key =
    messageList
        |> Dict.get key
        |> Maybe.withDefault ""
