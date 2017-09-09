module Decoder6 exposing (..)

import Html exposing (Html, button, div, h2, pre, text)
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
        [ h2 [] [ text "jsonA :: github id is present in json" ]
        , pre [] [ text jsonA ]
        , pre [] [ text (decodedValue jsonA) ]
        , h2 [] [ text "jsonB :: github id is missing in json" ]
        , pre [] [ text jsonB ]
        , pre [] [ text (decodedValue jsonB) ]
        , h2 [] [ text "jsonC :: github id is null in json" ]
        , pre [] [ text jsonC ]
        , pre [] [ text (decodedValue jsonC) ]
        ]
