module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http


main =
    Html.program { init = init, view = view, update = update, subscriptions = \_ -> Sub.none }


type alias Model =
    String


model : Model
model =
    "Please wait ...."


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
            Http.send PlanetMsg (buildRequest url)
    in
    cmd


buildRequest : String -> Http.Request String
buildRequest url =
    Http.request
        { method = "GET"
        , headers = []
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectStringResponse showResponse
        , timeout = Nothing
        , withCredentials = False
        }


showResponse : Http.Response String -> Result String String
showResponse resp =
    Just (toString resp)
        |> Result.fromMaybe "unknown"


type Msg
    = PlanetMsg (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlanetMsg (Ok value) ->
            ( value, Cmd.none )

        PlanetMsg (Err error) ->
            ( toString error, Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ text model ]
