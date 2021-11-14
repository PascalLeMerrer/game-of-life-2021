module StyleSheet exposing (..)

import Css exposing (backgroundColor, bold, border, borderColor, borderRadius, column, displayFlex, flexDirection, fontWeight, hex, margin, none, padding, pct, px, rem, row, width, zero)
import Css.Global exposing (button, class, global)
import Html.Styled


classes : Html.Styled.Html msg
classes =
    global
        [ class "container"
            [ displayFlex
            , flexDirection row
            , padding (rem 1)
            ]
        , class "buttons"
            [ displayFlex
            , flexDirection column
            ]
        , class "selected"
            [ fontWeight bold
            ]
        , button
            [ backgroundColor <| hex "71c7ec"
            , border zero
            , margin <| rem 1
            , padding <| rem 0.5
            , borderRadius <| px 5
            , width <| rem 11
            ]
        ]
