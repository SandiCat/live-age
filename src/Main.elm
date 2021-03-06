module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as Attrs exposing (style)
import Time


type Msg
    = NoOp
    | NewTime Time.Posix


main : Program Int Time.Posix Msg
main =
    Browser.application
        { init = \ms _ _ -> ( Time.millisToPosix ms, Cmd.none )
        , view = view
        , update =
            \msg model ->
                case msg of
                    NewTime newTime ->
                        ( newTime, Cmd.none )

                    _ ->
                        ( model, Cmd.none )
        , subscriptions = always <| Time.every 1 NewTime
        , onUrlRequest = always NoOp
        , onUrlChange = always NoOp
        }


view currentTime =
    let
        birthday =
            803779200000

        dt =
            Time.posixToMillis currentTime - birthday

        in_years =
            toFloat dt / (1000 * 60 * 60 * 24 * 365.25)
    in
    { title = "hey"
    , body =
        [ Html.main_
            []
            [ Html.div
                [ style "color" "#ff33cc"
                , style "font-size" "700%"
                , style "font-family" "monospace"
                , style "text-align" "center"
                , style "margin" "0"
                , style "position" "absolute"
                , style "top" "50%"
                , style "width" "100%"
                , style "transform" "translateY(-50%)"
                ]
                [ Html.text <| String.padRight 18 '0' <| String.fromFloat <| in_years ]
            ]
        ]
    }
