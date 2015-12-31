{-# LANGUAGE FlexibleContexts #-}

module Parse.Ecma6 where

import Text.Parsec as P
import Text.Parsec.Language (emptyDef)
import Text.Parsec.Combinator as C
import Text.Parsec.Token as Token

import Parse.Whitespace (lineTerminator)
import Parse.Comment (comment)

parseEcma6 input = P.parse ecma6 "" input

ecma6 :: Stream s m Char => ParsecT s u m [[Char]]
ecma6 = P.many line

line :: Stream s m Char => ParsecT s u m [Char]
line = comment <|> (lineTerminator >>= (\x -> return [x]))
