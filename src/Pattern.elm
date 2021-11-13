module Pattern exposing (..)


type alias Pattern =
    { cells : List Cell
    , name : String
    }


type alias Cell =
    { x : Int
    , y : Int
    }


all : List Pattern
all =
    [ blinker
    , clock
    , glider
    , gliderGun
    , lightWeightSpaceship
    , rPentamino
    , relay
    ]


empty : Pattern
empty =
    { name = "Empty"
    , cells = []
    }


blinker : Pattern
blinker =
    { name = "Blinker"
    , cells =
        [ { x = 9, y = 10 }
        , { x = 10, y = 10 }
        , { x = 11, y = 10 }
        ]
    }


clock : Pattern
clock =
    { name = "Clock"
    , cells =
        [ { x = 9, y = 10 }
        , { x = 10, y = 10 }
        , { x = 10, y = 8 }
        , { x = 11, y = 9 }
        , { x = 11, y = 11 }
        , { x = 12, y = 9 }
        ]
    }


glider : Pattern
glider =
    { name = "Glider"
    , cells =
        [ { x = 9, y = 9 }
        , { x = 9, y = 10 }
        , { x = 10, y = 10 }
        , { x = 11, y = 10 }
        , { x = 10, y = 8 }
        ]
    }


gliderGun : Pattern
gliderGun =
    { name = "Glider Gun"
    , cells =
        [ { x = 9, y = 9 }
        , { x = 9, y = 10 }
        , { x = 10, y = 9 }
        , { x = 10, y = 10 }
        , { x = 19, y = 9 }
        , { x = 19, y = 10 }
        , { x = 19, y = 11 }
        , { x = 20, y = 8 }
        , { x = 20, y = 12 }
        , { x = 21, y = 7 }
        , { x = 21, y = 13 }
        , { x = 22, y = 7 }
        , { x = 22, y = 13 }
        , { x = 23, y = 10 }
        , { x = 24, y = 8 }
        , { x = 24, y = 12 }
        , { x = 25, y = 9 }
        , { x = 25, y = 10 }
        , { x = 25, y = 11 }
        , { x = 26, y = 10 }
        , { x = 29, y = 7 }
        , { x = 29, y = 8 }
        , { x = 29, y = 9 }
        , { x = 30, y = 7 }
        , { x = 30, y = 8 }
        , { x = 30, y = 9 }
        , { x = 31, y = 6 }
        , { x = 31, y = 10 }
        , { x = 33, y = 5 }
        , { x = 33, y = 6 }
        , { x = 33, y = 10 }
        , { x = 33, y = 11 }
        , { x = 43, y = 7 }
        , { x = 43, y = 8 }
        , { x = 44, y = 7 }
        , { x = 44, y = 8 }
        ]
    }


lightWeightSpaceship : Pattern
lightWeightSpaceship =
    { name = "Lightweight Spaceship"
    , cells =
        [ { x = 10, y = 8 }
        , { x = 10, y = 10 }
        , { x = 11, y = 11 }
        , { x = 12, y = 11 }
        , { x = 13, y = 8 }
        , { x = 13, y = 11 }
        , { x = 14, y = 11 }
        , { x = 14, y = 10 }
        , { x = 14, y = 9 }
        ]
    }


rPentamino : Pattern
rPentamino =
    { name = "R-Pentamino"
    , cells =
        [ { x = 9, y = 10 }
        , { x = 10, y = 10 }
        , { x = 10, y = 9 }
        , { x = 10, y = 11 }
        , { x = 11, y = 9 }
        ]
    }


relay : Pattern
relay =
    { name = "Relay"
    , cells =
        [ { x = 10, y = 10 }
        , { x = 11, y = 10 }
        , { x = 12, y = 9 }
        , { x = 12, y = 11 }
        , { x = 13, y = 10 }
        , { x = 14, y = 10 }
        , { x = 15, y = 10 }
        , { x = 16, y = 10 }
        , { x = 17, y = 9 }
        , { x = 17, y = 11 }
        , { x = 18, y = 10 }
        , { x = 19, y = 10 }
        ]
    }
