{-# LANGUAGE FlexibleContexts #-}
module Parse.Comment where

import Text.Parsec (Stream, ParsecT, many, try, (<|>))
import Text.Parsec.Char (char, string)
import Text.Parsec.Combinator (count, manyTill, between)

import Parse.SourceCharacter (sourceCharacter)
import Parse.Whitespace (lineTerminator)

comment :: Stream s m Char => ParsecT s u m [Char]
comment = singleLineComment <|> multiLineComment

singleLineComment :: Stream s m Char => ParsecT s u m [Char]
singleLineComment = try $ do
    count 2 (char '/')
    manyTill sourceCharacter lineTerminator

--TODO: Does this follow the spec?
multiLineComment :: Stream s m Char => ParsecT s u m [Char]
multiLineComment = try $ between (string "/*") (string "*/") (many sourceCharacter)
