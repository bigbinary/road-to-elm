module Decoder2 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode exposing (Decoder, at, field, float, int, list, nullable, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)


json =
    """
[
  {
    "name": "Jack",
    "age": 24
  }
]
"""


type alias User =
    { name : String
    , age : Int
    }


userDecoder : Decoder User
userDecoder =
    decode User
        |> required "name" string
        |> required "age" int


decodedValue : String
decodedValue =
    let
        result =
            Json.Decode.decodeString (list userDecoder) json
    in
    case result of
        Ok value ->
            toString value

        Err error ->
            error


main =
    div []
        [ p [] [ text "----JSON input -----" ]
        , p [] [ text json ]
        , p [] [ text "----Decoded value -----" ]
        , p [] [ text decodedValue ]
        ]
