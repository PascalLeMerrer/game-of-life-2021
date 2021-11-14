module Main exposing (evolve, main, updateModel)

import Browser
import Color exposing (rgb)
import Html exposing (Html)
import Html.Styled exposing (button, div, text, toUnstyled)
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onClick)
import List.Extra as List
import Pattern exposing (Cell, Pattern)
import Random
import Random.List
import StyleSheet exposing (classes)
import Svg.Styled exposing (fromUnstyled)
import Time exposing (Posix)
import TypedSvg exposing (rect, svg)
import TypedSvg.Attributes exposing (fill, stroke, viewBox)
import TypedSvg.Attributes.InPx exposing (height, width, x, y)
import TypedSvg.Types exposing (Paint(..))


type alias Model =
    { cells : List Cell
    , selectedPattern : Maybe Pattern
    }


type Msg
    = Tick Posix
    | UserSelected Pattern
    | UserClickedGenerateRandomPattern
    | RuntimeSelectedRandomNumbers ( List Int, List Int )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { cells = Pattern.blinker.cells
      , selectedPattern = Just Pattern.blinker
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | cells = updateModel model }
            , Cmd.none
            )

        UserSelected pattern ->
            ( { cells = pattern.cells
              , selectedPattern = Just pattern
              }
            , Cmd.none
            )

        UserClickedGenerateRandomPattern ->
            let
                generator =
                    List.range 1 20
                        |> Random.List.choices 10
            in
            ( { model | selectedPattern = Nothing }
            , Random.generate RuntimeSelectedRandomNumbers generator
            )

        RuntimeSelectedRandomNumbers ( chosenNumbers, _ ) ->
            let
                cells =
                    chosenNumbers
                        |> List.uniquePairs
                        |> List.map (\( x, y ) -> { x = x, y = y })
            in
            ( { model | cells = cells }, Cmd.none )


updateModel model =
    model.cells
        |> List.concatMap neighbours
        |> List.unique
        |> List.concatMap (\cell -> evolve cell model)


evolve : Cell -> Model -> List Cell
evolve cell model =
    case neighboursCount cell model of
        2 ->
            if List.member cell model.cells then
                -- cell is alive and has two neighbours
                [ cell ]

            else
                []

        3 ->
            [ cell ]

        _ ->
            []


neighboursCount : Cell -> Model -> Int
neighboursCount cell model =
    model.cells
        |> List.filter (\c -> List.member c (neighbours cell))
        |> List.length


neighbours : Cell -> List Cell
neighbours cell =
    [ { x = cell.x - 1, y = cell.y - 1 }
    , { x = cell.x, y = cell.y - 1 }
    , { x = cell.x + 1, y = cell.y - 1 }
    , { x = cell.x - 1, y = cell.y }
    , { x = cell.x + 1, y = cell.y }
    , { x = cell.x - 1, y = cell.y + 1 }
    , { x = cell.x, y = cell.y + 1 }
    , { x = cell.x + 1, y = cell.y + 1 }
    ]


view : Model -> Html Msg
view model =
    toUnstyled <|
        div [ class "container" ]
            [ classes
            , div [ class "buttons" ] <|
                List.map (viewButton model) Pattern.all
                    ++ [ button [ onClick UserClickedGenerateRandomPattern ] [ text "Pseudo-random" ] ]
            , div
                [ class "container"
                ]
                [ fromUnstyled <|
                    svg
                        [ width 1000
                        , height 1000
                        , viewBox 0 0 1000 1000
                        ]
                        (List.map viewCell model.cells)
                ]
            ]


viewButton : Model -> Pattern -> Html.Styled.Html Msg
viewButton model pattern =
    let
        className =
            case model.selectedPattern of
                Just selectedPattern ->
                    if pattern == selectedPattern then
                        "selected"

                    else
                        ""

                _ ->
                    ""
    in
    button
        [ class className
        , onClick (UserSelected pattern)
        ]
        [ text pattern.name ]


viewCell cell =
    rect
        [ x <| toFloat (cell.x * 10)
        , y <| toFloat (cell.y * 10)
        , width 10
        , height 10
        , fill <| Paint (rgb 0 0.31 0.45)
        , stroke <| Paint (rgb 1 1 1)
        ]
        []


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 100 Tick
