module Decoder5 exposing (..)

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
        [ p [] [ text "----jsonA ----- github id is present" ]
        , p [] [ text jsonA ]
        , p [] [ text (decodedValue jsonA) ]
        , p [] [ text "----jsonB----- github id is null" ]
        , p [] [ text jsonB ]
        , p [] [ text (decodedValue jsonB) ]
        ]
