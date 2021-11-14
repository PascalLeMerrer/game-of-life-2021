module MainTest exposing (..)

import Expect exposing (Expectation)
import Main exposing (evolve, updateModel)
import Pattern exposing (empty)
import Test exposing (..)


suite : Test
suite =
    describe "The Game Of Life module"
        [ describe "evolve"
            [ test "kill cell with not enough neighbours" <|
                \_ ->
                    { selectedPattern = empty, cells = [ { x = 1, y = 1 } ] }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal []
            , test "kill cell with more than 3 neighbours" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 0, y = 0 }
                        , { x = 0, y = 1 }
                        , { x = 2, y = 1 }
                        , { x = 1, y = 2 }
                        ]
                    }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal []
            , test "let live cell with 2 neighbours" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 1, y = 0 }
                        , { x = 1, y = 1 }
                        , { x = 1, y = 2 }
                        ]
                    }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal [ { x = 1, y = 1 } ]
            , test "let live cell with 3 neighbours" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 1, y = 1 }
                        , { x = 2, y = 1 }
                        , { x = 1, y = 2 }
                        ]
                    }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal [ { x = 1, y = 1 } ]
            , test "create cell when 3 neighbours to the right" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 2, y = 0 }
                        , { x = 2, y = 1 }
                        , { x = 2, y = 2 }
                        ]
                    }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal [ { x = 1, y = 1 } ]
            , test "create cell when 3 neighbours to the left" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 0, y = 0 }
                        , { x = 0, y = 1 }
                        , { x = 0, y = 2 }
                        ]
                    }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal [ { x = 1, y = 1 } ]
            , test "ignore cells outside its neighbourhood" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 3, y = 0 }
                        , { x = 3, y = 1 }
                        , { x = 3, y = 2 }
                        ]
                    }
                        |> evolve { x = 1, y = 1 }
                        |> Expect.equal
                            []
            ]
        , describe "updateModel"
            [ test "flips horizontal bar to vertical bar" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 0, y = 1 }
                        , { x = 1, y = 1 }
                        , { x = 2, y = 1 }
                        ]
                    }
                        |> updateModel
                        |> Expect.equal
                            [ { x = 1, y = 0 }
                            , { x = 1, y = 1 }
                            , { x = 1, y = 2 }
                            ]
            , test "flips vertical bar to horizontal bar" <|
                \_ ->
                    { selectedPattern = empty
                    , cells =
                        [ { x = 1, y = 0 }
                        , { x = 1, y = 1 }
                        , { x = 1, y = 2 }
                        ]
                    }
                        |> updateModel
                        |> Expect.equal
                            [ { x = 0, y = 1 }
                            , { x = 1, y = 1 }
                            , { x = 2, y = 1 }
                            ]
            ]
        ]
