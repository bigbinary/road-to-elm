module Decoder1 exposing (..)

import Html exposing (Html, button, div, h2, pre, text)
import Json.Decode as JD


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



-- MODEL


type alias User =
    { name : String
    , age : Int
    , city : String
    , married : Bool
    }



-- DECODERS


userDecoder : JD.Decoder User
userDecoder =
    JD.map4 User
        (JD.field "name" JD.string)
        (JD.field "age" JD.int)
        (JD.field "city" JD.string)
        (JD.field "married" JD.bool)


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
