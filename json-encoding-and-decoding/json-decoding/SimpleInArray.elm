module Main exposing (..)

import Html exposing (Html, button, div, h2, pre, text)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


-- INPUT


json : String
json =
    """
[
  {
    "name": "Jack",
    "age": 24
  }
]
"""



-- MODEL


type alias User =
    { name : String
    , age : Int
    }



-- DECODERS


userDecoder : JD.Decoder User
userDecoder =
    JP.decode User
        |> JP.required "name" JD.string
        |> JP.required "age" JD.int


decodedValue : String
decodedValue =
    let
        result =
            JD.decodeString (JD.list userDecoder) json
    in
        case result of
            Ok value ->
                toString value

            Err error ->
                error



-- VIEW


main : Html msg
main =
    div []
        [ h2 [] [ text "JSON Input" ]
        , pre [] [ text json ]
        , h2 [] [ text "Decoded Value" ]
        , pre [] [ text decodedValue ]
        ]
