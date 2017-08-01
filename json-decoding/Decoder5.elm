module Decoder5 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder, at, field, float, int, list, nullable, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)


json5a =
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


json5b =
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
        |> required "githubid" (nullable string)


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
        [ p [] [ text "----json5a ----- github id is present" ]
        , p [] [ text json5a ]
        , p [] [ text (decodedValue json5a) ]
        , p [] [ text "----json5b----- github id is null" ]
        , p [] [ text json5b ]
        , p [] [ text (decodedValue json5b) ]
        ]
