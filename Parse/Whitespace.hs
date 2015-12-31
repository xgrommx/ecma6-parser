{-# LANGUAGE FlexibleContexts #-}
module Parse.Whitespace where

import Text.Parsec as P
import Text.Parsec.Char as C
import Text.Parsec.Combinator (choice, notFollowedBy, many1)

whitespace :: Stream s m Char => ParsecT s u m [Char]
whitespace = many1 whitespaceCharacter

newlines :: Stream s m Char => ParsecT s u m [Char]
newlines = many1 lineTerminator

whitespaceCharacter :: Stream s m Char => ParsecT s u m Char
whitespaceCharacter = C.oneOf
    [ '\x0009' -- character tab
    , '\x000B' -- line tab
    , '\x000C' -- form feed
    , '\x0020' -- space
    , '\x00A0' -- non-breaking space
    , '\xFEFF' -- zero width non-breaking space
    ]

lf :: Stream s m Char => ParsecT s u m Char
lf = C.char '\x000A'
cr :: Stream s m Char => ParsecT s u m Char
cr = C.char '\x000D'
ls :: Stream s m Char => ParsecT s u m Char
ls = C.char '\x2028'
ps :: Stream s m Char => ParsecT s u m Char
ps = C.char '\x2029'

lineTerminator :: Stream s m Char => ParsecT s u m Char
lineTerminator = choice
    [ lf
    , cr
    , ls
    , ps
    ]

lineTerminatorSequence :: Stream s m Char => ParsecT s u m Char
lineTerminatorSequence = choice
    [ lf
    , cr >>= (\x -> notFollowedBy lf >> return x)
    , ls
    , ps
    , cr >> lf
    ]
