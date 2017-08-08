module Decoder8 exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Json.Decode as JD
import Json.Decode.Pipeline as JP


--https://ellie-app.com/3VjdtsVDqYta1/4
--Ok ([
--{ attribute = "format", id = "a3", title = "Flyer A3", subtitle = "297 × 420mm", image = Just "path/to/img.jpg" },
--{ attribute = "format", id = "a4", title = "Flyer A4", subtitle = "210 × 297mm", image = Just "path/to/img.jpg" },
--{ attribute = "material", id = "150g", title = "150 grams", subtitle = "Some text here", image = Nothing },
--{ attribute = "material", id = "300g", title = "300 grams", subtitle = "Some text here", image = Nothing },
--{ attribute = "printing", id = "4/0", title = "One-sided full color (4/0)", subtitle = "Some text here", image = Nothing },
--{ attribute = "printing", id = "4/4", title = "Two-sided full color (4/4)", subtitle = "Some text here", image = Nothing }
--])


json =
    """
{
  "title": "Product",
  "attributes": {
    "format": {
      "id": "format",
      "title": "Format",
      "options": {
        "a4": {
          "title": "Flyer A4",
          "subtitle": "210 × 297mm",
          "image": "path/to/img.jpg"
        },
        "a3": {
          "title": "Flyer A3",
          "subtitle": "297 × 420mm",
          "image": "path/to/img.jpg"
        }
      }
    },
    "printing": {
      "id": "printing1",
      "title": "Printing2",
      "options": {
        "4/0": {
          "title": "One-sided full color (4/0)",
          "subtitle": "Some text here"
        },
        "4/4": {
          "title": "Two-sided full color (4/4)",
          "subtitle": "Some text here"
        }
      }
    },
    "material": {
      "id": "material",
      "title": "Material",
      "options": {
        "300g": {
          "title": "300 grams",
          "subtitle": "Some text here"
        },
        "150g": {
          "title": "150 grams",
          "subtitle": "Some text here"
        }
      }
    }
  }
}
    """


type alias Option =
    { attribute : String
    , id : String
    , title : String
    , subtitle : String
    , image : Maybe String
    }


type alias Opt =
    { title : String
    , subtitle : String
    , image : Maybe String
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
