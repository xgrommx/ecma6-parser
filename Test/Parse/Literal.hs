module Test.Parse.Literal where

import Test.HUnit as HU
import Text.Parsec (parse)
import Text.Parsec.Error as TPE

import Parse.Literal (nullLiteral, boolLiteral)
import AST.Literal as AST

import Test.Parse.Helpers (parseTest)

main = HU.runTestTT tests

tests = TestList
    [ TestLabel "Null" testNull
    , TestLabel "Boolean" testBool
    ]

testNull :: Test
testNull =
    let input = "null"
        parsedInput = parse nullLiteral "" input
        comment = "null parses"
    in
        TestLabel comment (parseTest comment (AST.Null) parsedInput)

testBool :: Test
testBool =
    let true = ("True", "true", AST.Boolean AST.True)
        false = ("False", "false", AST.Boolean AST.False)
        parseInput = parse boolLiteral ""
        makeTest (label, input, expected) = TestLabel label (parseTest label expected (parseInput input))
    in  TestList
        [ makeTest true
        , makeTest false
        ]


    
