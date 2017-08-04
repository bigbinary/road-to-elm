module Decoder5 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


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
        [ p [] [ text "----json5a ----- github id is present" ]
        , p [] [ text json5a ]
        , p [] [ text (decodedValue json5a) ]
        , p [] [ text "----json5b----- github id is null" ]
        , p [] [ text json5b ]
        , p [] [ text (decodedValue json5b) ]
        ]
