module Decoder5 exposing (..)

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
    , githubid : Maybe String
    }


userDecoder : JD.Decoder User
userDecoder =
    JP.decode User
        |> JP.required "name" JD.string
        |> JP.required "age" JD.int
        |> JP.required "githubid" (JD.nullable JD.string)


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
        [ h2 [] [ text "jsonA :: github id is present" ]
        , pre [] [ text jsonA ]
        , pre [] [ text (decodedValue jsonA) ]
        , h2 [] [ text "jsonB :: github id is null" ]
        , pre [] [ text jsonB ]
        , pre [] [ text (decodedValue jsonB) ]
        ]
