module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    String


model : Model
model =
    "Please wait ...."


type Msg
    = Noop


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div [] [ text model ]
