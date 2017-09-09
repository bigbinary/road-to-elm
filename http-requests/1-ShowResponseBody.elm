module Main exposing (..)

import Html exposing (..)
import Http


-- MODEL


type alias Model =
    String


model : Model
model =
    "Please wait...."


init : ( Model, Cmd Msg )
init =
    ( model, planetInfo )


planetInfo : Cmd Msg
planetInfo =
    let
        url =
            "http://swapi.co/api/people/1"

        request =
            Http.getString url

        cmd =
            Http.send PlanetMsg request
    in
        cmd



-- UPDATE


type Msg
    = PlanetMsg (Result Http.Error String)


update : Msg -> Model -> ( String, Cmd msg )
update msg model =
    case msg of
        PlanetMsg (Ok value) ->
            ( value, Cmd.none )

        PlanetMsg (Err error) ->
            ( toString error, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    pre [] [ text model ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
