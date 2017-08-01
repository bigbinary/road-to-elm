module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    String


model : Model
model =
    "Please wait ...."


planetInfo : Cmd Msg
planetInfo =
    let
        url =
            "swapi.co/api/planets/1/"

        request =
            Http.getString url

        cmd =
            Http.send PlanetInMotion request
    in
    cmd


type Msg
    = PlanetInMotion (Result Http.Error String)


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div [] [ text model ]
