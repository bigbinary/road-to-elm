{-
   In this example, we decode a simple JSON string containing values
   of simple types such as String, Int and Bool.

   To decode, we rely on 'Json.Decode' module from core package.

   You can check the result of this example on the following link:
   https://embed.ellie-app.com/4g7XT7TZ6Dma1/1
-}


module Main exposing (..)

import Html exposing (Html, button, div, h2, pre, text)
import Json.Decode
    exposing
        ( Decoder
        , field
        , int
        , string
        , bool
        , decodeString
        , map4
        )


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
{-
   Notice the use of 'map4' function in 'userDecoder' below.
   '4' in 'map4' denotes the number of decoderd it can accept as an argument.
   There are map functions from 'map' to 'map8'.
   It is advised to use 'elm-decode-pipeline' package when we run out of such
   map functions.

   If we see the signature of 'map4' function, it looks like this:
        map4
            :  (a -> b -> c -> d -> value)
            -> Decoder a
            -> Decoder b
            -> Decoder c
            -> Decoder d
            -> Decoder value
   From above signature, the first argument of 'map4' should be a function
   which can accept 4 arguments and return a 'value' which should be of
   'User' type.
   We have provided 'User' alias type as the first argument to 'map4' function.
   This is possible because a record type alias can be called as a function.
   Therefore, a 'User' type alias can be constructed with 4 arguments
   considering it accepts an argument for each field.

   Note that, another version of this example is available using
   'elm-decode-pipeline' package in "SimpleWithPipeline.elm" file in this
   directory.
-}


userDecoder : Decoder User
userDecoder =
    map4 User
        (field "name" string)
        (field "age" int)
        (field "city" string)
        (field "married" bool)



{-
   The 'decodedValue' function is just a normal function which we call in our
   "main" view function below to display the decoded JSON string.

   We use 'Json.Decode.decodeString' function, which accepts
   a decoder and the string need to be decoded (i.e. a JSON string).
   'decodeString' function returns a 'Result' off which we can obtain the
   decoded value which can either be of type 'User' or an error.
-}


decodedValue : String
decodedValue =
    let
        result =
            decodeString userDecoder json
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
