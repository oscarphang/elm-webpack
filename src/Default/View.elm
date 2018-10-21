module View exposing (onChange, renderNameItem, renderUserInfo, showLoading, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick)
import Json.Decode exposing (map)
import Type exposing (..)


renderNameItem : ( Int, String ) -> Html Msg
renderNameItem ( userid, name ) =
    option [ value <| String.fromInt userid ] [ text name ]


showLoading : Bool -> Html Msg
showLoading isLoading =
    case isLoading of
        True ->
            span [] [ text "Loading" ]

        False ->
            span [] []


renderUserInfo : Maybe User -> List (Html Msg)
renderUserInfo userProfile =
    case userProfile of
        Just user ->
            [ p [] [ span [] [ text "name:" ], span [] [ text user.name ] ]
            , p [] [ span [] [ text "username:" ], span [] [ text user.username ] ]
            , p [] [ span [] [ text "email:" ], span [] [ text user.email ] ]
            ]

        Nothing ->
            [ span []
                [ text "No User Selected."
                ]
            ]


view : Model -> Html Msg
view model =
    div []
        [ model.users
            |> List.map (\user -> ( user.id, user.name ))
            |> List.map renderNameItem
            |> select [ onChange RequestUserProfile ]
        , showLoading model.isLoading
        , model.selectedUser
            |> renderUserInfo
            |> div []
        ]


onChange : (String -> msg) -> Html.Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger Html.Events.targetValue)
