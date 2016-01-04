module Test.Parse.Helpers where

import qualified Test.HUnit as HU
import Text.Parsec (ParseError)

parseTest :: (Eq a, Show a) => [Char] -> a -> Either ParseError a -> HU.Test
parseTest msg e = HU.TestCase . either (HU.assertFailure . show) (HU.assertEqual msg e)
