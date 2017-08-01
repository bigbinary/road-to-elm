module Decoder7 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder, at, field, float, int, list, null, nullable, oneOf, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)


json6a =
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


json6b =
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


json6c =
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


userDecoder : Decoder User
userDecoder =
    decode User
        |> required "name" string
        |> required "age" int
        --|> optional "githubid" (nullable string) (Just "")
        |> optional "githubid" (nullable string) Nothing


decodedValue : String -> String
decodedValue json =
    let
        result =
            Json.Decode.decodeString (at [ "github", "users" ] (list userDecoder)) json
    in
    case result of
        Ok value ->
            toString value

        Err error ->
            error


main =
    div []
        [ p [] [ text "----json6a -----github id is present in json" ]
        , p [] [ text json6a ]
        , p [] [ text (decodedValue json6a) ]
        , p [] [ text "----json6b-----github id is missing in json" ]
        , p [] [ text json6b ]
        , p [] [ text (decodedValue json6b) ]
        , p [] [ text "----json6c-----github id is null in json" ]
        , p [] [ text json6c ]
        , p [] [ text (decodedValue json6c) ]
        ]
