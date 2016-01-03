{-# LANGUAGE FlexibleContexts #-}
module Parse.Comment where

import Text.Parsec (Stream, ParsecT, many, try, (<|>))
import Text.Parsec.Char (char, string)
import Text.Parsec.Combinator (count, manyTill, between, notFollowedBy, many1, lookAhead)

import Parse.SourceCharacter (sourceCharacter)
import Parse.Whitespace (lineTerminator)
import Parse.Language (symbol)

comment :: Stream s m Char => ParsecT s u m ()
comment = singleLineComment <|> multiLineComment

singleLineComment :: Stream s m Char => ParsecT s u m ()
singleLineComment = try $ do
    count 2 (char '/')
    manyTill sourceCharacter lineTerminator
    return ()

multiLineComment :: Stream s m Char => ParsecT s u m ()
multiLineComment = do
    string "/*"
    manyTill sourceCharacter $ try (string "*/")
    return ()

