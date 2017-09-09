module Main exposing (..)

import Html exposing (Html, button, div, h2, pre, text)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


-- INPUT


json : String
json =
    """
{
  "name": "Jack",
  "age": 24,
  "city": "New York",
  "married": true
}
"""



-- TYPES


type alias User =
    { name : String
    , age : Int
    , city : String
    , married : Bool
    }



-- DECODERS


userDecoder : JD.Decoder User
userDecoder =
    JP.decode User
        |> JP.required "name" JD.string
        |> JP.required "age" JD.int
        |> JP.required "city" JD.string
        |> JP.required "married" JD.bool


decodedValue : String
decodedValue =
    let
        result =
            JD.decodeString userDecoder json
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
