module Test.Parse.Comment where

import Test.HUnit as HU
import Text.Parsec (parse)
import Text.Parsec.Error as TPE

import Parse.Comment (multiLineComment)

main = HU.runTestTT tests

tests = TestList
    [ TestLabel "Multiline Comment" testMultiLineComment
    ]

parseTest :: String -> String -> Either ParseError String -> Test
parseTest msg e = TestCase . either (HU.assertFailure . show) (HU.assertEqual msg e)

testMultiLineComment :: Test
testMultiLineComment =
    let expected = "asdf"
        input = "/*asdf*/"
        observed = parse multiLineComment "" input
    in
        parseTest "asdf" "asdf" observed

