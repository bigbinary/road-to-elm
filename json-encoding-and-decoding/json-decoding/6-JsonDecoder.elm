module Decoder6 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


jsonA =
    """
{
  "github": {
    "users": [
      {
        "name": "Jack",
        "age": 24,
        "githubid": "evancz"
      }
    ]
  }
}
"""


jsonB =
    """
{
  "github": {
    "users": [
      {
        "name": "Jack",
        "age": 24
      }
    ]
  }
}
"""


jsonC =
    """
{
  "github": {
    "users": [
      {
        "name": "Jack",
        "age": 24,
        "githubid": null
      }
    ]
  }
}
"""


type alias User =
    { name : String
    , age : Int
    , githubid : String
    }


userDecoder : JD.Decoder User
userDecoder =
    JP.decode User
        |> JP.required "name" JD.string
        |> JP.required "age" JD.int
        |> JP.optional "githubid" (JD.oneOf [ JD.string, JD.null "NULL" ]) "MISSING"


decodedValue : String -> String
decodedValue json =
    let
        result =
            JD.decodeString (JD.at [ "github", "users" ] (JD.list userDecoder)) json
    in
    case result of
        Ok value ->
            toString value

        Err error ->
            error


main =
    div []
        [ p [] [ text "----jsonA -----github id is present in json" ]
        , p [] [ text jsonA ]
        , p [] [ text (decodedValue jsonA) ]
        , p [] [ text "----jsonB-----github id is missing in json" ]
        , p [] [ text jsonB ]
        , p [] [ text (decodedValue jsonB) ]
        , p [] [ text "----jsonC-----github id is null in json" ]
        , p [] [ text jsonC ]
        , p [] [ text (decodedValue jsonC) ]
        ]
