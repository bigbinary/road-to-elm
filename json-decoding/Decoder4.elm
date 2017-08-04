module Decoder4 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


json =
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


type alias User =
    { name : String
    , age : Int
    }


userDecoder : JD.Decoder User
userDecoder =
    JP.decode User
        |> JP.required "name" JD.string
        |> JP.required "age" JD.int


decodedValueUsingAt : String
decodedValueUsingAt =
    let
        result =
            JD.decodeString (JD.at [ "github", "users" ] (JD.list userDecoder)) json
    in
    case result of
        Ok value ->
            toString value

        Err error ->
            error


decodedValueUsingField : String
decodedValueUsingField =
    let
        result =
            JD.decodeString (JD.field "github" (JD.field "users" (JD.list userDecoder))) json
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
        , p [] [ text "----Decoded value using at -----" ]
        , p [] [ text decodedValueUsingAt ]
        , p [] [ text "----Decoded value using field -----" ]
        , p [] [ text decodedValueUsingField ]
        ]
