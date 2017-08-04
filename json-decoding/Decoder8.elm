module Decoder8 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


json8 =
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
        --|> JP.optional "githubid" (JD.nullable JD.string) (Just "")
        |> JP.optional "githubid" (JD.nullable JD.string) Nothing


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
