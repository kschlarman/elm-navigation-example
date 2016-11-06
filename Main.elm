module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)
import Html.Attributes exposing (href)
import Navigation


main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { page : Page
    }


type Page
    = HomePage
    | AboutPage
    | ContactPage
    | NotFound


init : Page -> ( Model, Cmd Msg )
init page =
    ( { page = page }, Cmd.none )



-- UPDATE


type Msg
    = ShowHome
    | ShowAbout
    | ShowContact


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowHome ->
            ( model, Navigation.newUrl "#/home" )

        ShowAbout ->
            ( model, Navigation.newUrl "#/about" )

        ShowContact ->
            ( model, Navigation.newUrl "#/contact" )


urlUpdate : Page -> Model -> ( Model, Cmd Msg )
urlUpdate page state =
    ( { state | page = page }, Cmd.none )



-- PARSER


urlParser : Navigation.Parser Page
urlParser =
    Navigation.makeParser hashParser


hashParser : Navigation.Location -> Page
hashParser location =
    case location.hash of
        "#/home" ->
            HomePage

        "#/about" ->
            AboutPage

        "#/contact" ->
            ContactPage

        _ ->
            NotFound



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ a [ onClick ShowHome, href "#/home" ] [ text "Home" ]
        , a [ onClick ShowAbout, href "#/about" ] [ text "About" ]
        , a [ onClick ShowContact, href "#/contact" ] [ text "Contact" ]
        , div []
            [ text (toString model.page) ]
        ]
