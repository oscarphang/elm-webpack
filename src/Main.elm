module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Browser exposing (..)
import Json.Decode as Decode exposing (Decoder, int, string, float)
import Json.Decode.Pipeline exposing (required, optional, hardcoded)


--model


type alias Flags =
    { employees : List Employee
    }


type alias Employee =
    { name : String
    , country : String
    }


type Order
    = NoOrder
    | Asc
    | Desc


type AvailableField
    = NoField
    | Name
    | Country


type alias Model =
    { fieldToSort : AvailableField
    , orderIn : Order
    , employees : List Employee
    , displayEmployees : List Employee
    }


initModel : Model
initModel =
    { fieldToSort = NoField
    , orderIn = NoOrder
    , employees = []
    , displayEmployees = []
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { initModel | employees = flags.employees, displayEmployees = flags.employees }, Cmd.none )


type Msg
    = SortName
    | SortCountry



--view


renderEmployee : Employee -> Html Msg
renderEmployee employee =
    tr []
        [ td [] [ text employee.name ]
        , td [] [ text employee.country ]
        ]


view : Model -> Html Msg
view model =
    table []
        [ thead []
            [ tr []
                [ td [ onClick SortName ] [ text "Name" ]
                , td [ onClick SortCountry ] [ text "Country" ]
                ]
            ]
        , List.map renderEmployee model.displayEmployees
            |> tbody []
        ]



--update


descending a b =
    case compare a b of
        LT ->
            GT

        EQ ->
            EQ

        GT ->
            LT


newOrderByField : Model -> AvailableField -> Order
newOrderByField model field =
    if model.fieldToSort == field && model.orderIn == Asc then
        Desc
    else
        Asc


sortListByOrder : Order -> List Employee -> List Employee
sortListByOrder order list =
    case order of
        Desc ->
            list
                |> List.reverse

        Asc ->
            list
        
        NoOrder ->
            initModel.employees



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SortName ->
            let
                newOrder =
                    newOrderByField model Name

                newEmployees =
                    model.employees
                    |>  List.sortBy .name
                    |> sortListByOrder newOrder
            in
                ( { model | orderIn = newOrder, fieldToSort = Name, displayEmployees = newEmployees }, Cmd.none )

        SortCountry ->
            let
                newOrder =
                    newOrderByField model Country

                newEmployees =
                    model.employees
                    |>  List.sortBy .country
                    |> sortListByOrder newOrder
            in
                ( { model | orderIn = newOrder, fieldToSort = Country, displayEmployees = newEmployees }, Cmd.none )



-- SortName ->
--     { model | count = model.count + 1 }
-- SortCountry ->
--     { model | count = model.count - 1 }
--program


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
