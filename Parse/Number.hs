module Parse.Number where

import Text.Parsec as P
import Text.Parsec.Token as T
import Text.Parsec.Language as L

-- Lexers

languageDef =
    L.emptyDef
        { T.commentStart = "/*"
        , T.commentEnd = "*/"
        , T.commentLine = "//"
        , T.nestedComments = True
        , T.identStart = P.letter
        , T.caseSensitive = True
        }

main = undefined
