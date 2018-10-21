module State exposing (init, subscriptions, update)

import Api exposing (..)
import Port exposing (..)
import Type exposing (..)
import Util exposing (..)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { users = []
      , selectedUser = Nothing
      , isLoading = False
      , errorMsg = Nothing
      }
    , getAllUserFromServer
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        RequestUserList ->
            ( { model | isLoading = True }, getAllUserFromServer )

        RequestUserProfile userid ->
            ( { model | isLoading = True }, getUserDetailFromServer userid )

        ReceivedUserDetail (Ok user) ->
            ( { model | selectedUser = Just user, isLoading = False }, Cmd.none )

        ReceivedUserDetail (Err error) ->
            ( { model | errorMsg = Just error, isLoading = False }, Cmd.none )

        ReceivedAllUser (Ok users) ->
            ( { model | users = users, isLoading = False }, Cmd.none )

        ReceivedAllUser (Err error) ->
            ( { model | errorMsg = Just error, isLoading = False }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []
