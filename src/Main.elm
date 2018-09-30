module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Browser exposing (..)


--model


type alias Model =
    { count : Int
    }


initModel =
    Model 0


type Msg
    = Increment
    | Decrement



--view


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "button", onClick Increment, value "+" ] []
        , span [] [ text <| String.fromInt model.count ]
        , input [ type_ "button", onClick Decrement, value "-" ] []
        , span [] [ text "hey :)" ]
        ]



--update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }



--program


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
