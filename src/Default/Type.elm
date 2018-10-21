module Type exposing (Address, Flags, Model, Msg(..), User)

import Http


type alias Flags =
    {}


type alias Model =
    { users : List User
    , selectedUser : Maybe User
    , isLoading : Bool
    , errorMsg : Maybe Http.Error
    }


type alias User =
    { id : Int
    , name : String
    , username : String
    , email : String
    , address : Address
    }


type alias Address =
    { street : String
    , suite : String
    , city : String
    }


type Msg
    = NoOp
    | ReceivedAllUser (Result Http.Error (List User))
    | ReceivedUserDetail (Result Http.Error User)
    | RequestUserList
    | RequestUserProfile String
