{-# LANGUAGE FlexibleContexts #-}
module Parse.Comment where

import Text.Parsec (Stream, ParsecT, many, try, (<|>))
import Text.Parsec.Char (char, string)
import Text.Parsec.Combinator (count, manyTill, between, notFollowedBy, many1, lookAhead)

import Parse.SourceCharacter (sourceCharacter)
import Parse.Whitespace (lineTerminator)
import Parse.Language (symbol)

--comment :: Stream s m Char => ParsecT s u m [Char]
comment = singleLineComment <|> multiLineComment

--singleLineComment :: Stream s m Char => ParsecT s u m [Char]
singleLineComment = try $ do
    count 2 (char '/')
    manyTill sourceCharacter lineTerminator

--TODO: Does this follow the spec?
--answer: no.
--multiLineComment :: Stream s m Char => ParsecT s u m [Char]
multiLineComment = try $ do
    symbol "/*"
    cs <- multiLineComment <|> (manyTill sourceCharacter $ symbol "*/")
    symbol "*/"
    return cs
