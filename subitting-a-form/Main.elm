module SubmitingAForm exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { url : String }


model : Model
model =
    { url = "" }



-- UPDATE


type Msg
    = Submit
    | ChangeUrl String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeUrl newUrl ->
            { model | url = newUrl }

        Submit ->
            let
                _ =
                    Debug.log "new url is" model.url
            in
            model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Submit, action "javascript:void(0)" ]
            [ input [ name "url", type_ "text", onInput ChangeUrl, value model.url ] []
            , button [ type_ "Submit" ] [ text "Submit" ]
            ]
        ]
