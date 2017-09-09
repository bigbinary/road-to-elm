module SubmitingAForm exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
    { name : String }


model : Model
model =
    { name = "" }



-- UPDATE


type Msg
    = Submit
    | ChangeName String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeName newname ->
            { model | name = newname }

        Submit ->
            let
                _ =
                    Debug.log "" model.name
            in
                model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text "Please enter your name. Open browser console to see what got submitted." ]
        , Html.form [ onSubmit Submit, action "javascript:void(0)" ]
            [ input [ name "name", type_ "text", onInput ChangeName, value model.name ] []
            , button [ type_ "Submit" ] [ text "Submit" ]
            ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }
