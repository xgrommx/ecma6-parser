{-# LANGUAGE FlexibleContexts #-}
module Parse.SourceCharacter where

import Text.Parsec
import Text.Parsec.Char as C

sourceCharacter :: Stream s m Char => ParsecT s u m Char
sourceCharacter = C.anyChar
