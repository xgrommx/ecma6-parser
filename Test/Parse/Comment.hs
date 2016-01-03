module Test.Parse.Comment where

import Test.HUnit as HU
import Text.Parsec (parse)
import Text.Parsec.Error as TPE

import Parse.Comment (multiLineComment)

main = HU.runTestTT tests

tests = TestList
    [ TestLabel "Multiline Comment" testMultiLineComment
    ]

parseTest :: (Eq a, Show a) => [Char] -> a -> Either ParseError a -> Test
parseTest msg e = TestCase . either (HU.assertFailure . show) (HU.assertEqual msg e)

testMultiLineComment :: Test
testMultiLineComment =
    let makeInput x = "/*" ++ x ++ "*/"
        blockTests = 
            [ ("simple block comment", "asdf")
            , ("empty block comment", [])
            , ("newline", "\n")
            , ("nested empty block comment", "/**/")
            , ("newline and incomplete nested comment", "\n/*\n")
            ]
        parseSample :: String -> Either ParseError ()
        parseSample test = parse multiLineComment "" $ makeInput test
        makeTest :: (String, String) -> Test
        makeTest (comment, input) = TestLabel comment (parseTest comment () (parseSample input))
    in
        TestList $ map makeTest blockTests

