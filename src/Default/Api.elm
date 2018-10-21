module Api exposing (addressDecoder, getAllUserFromServer, getUserDetailFromServer, userDecoder)

import Http
import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (hardcoded, optional, required, requiredAt)
import Type exposing (Address, Msg(..), User)


userDecoder : Decoder User
userDecoder =
    Decode.succeed User
        |> required "id" int
        |> required "name" string
        -- `null` decodes to `Nothing`
        |> required "username" string
        |> required "email" string
        |> required "address" addressDecoder


addressDecoder : Decoder Address
addressDecoder =
    Decode.succeed Address
        |> required "street" string
        |> required "suite" string
        -- `null` decodes to `Nothing`
        |> required "city" string


getUserDetailFromServer : String -> Cmd Msg
getUserDetailFromServer userid =
    userDecoder
        |> Http.get ("https://jsonplaceholder.typicode.com/users/" ++ userid)
        |> Http.send ReceivedUserDetail


getAllUserFromServer : Cmd Msg
getAllUserFromServer =
    list userDecoder
        |> Http.get "https://jsonplaceholder.typicode.com/users"
        |> Http.send ReceivedAllUser
