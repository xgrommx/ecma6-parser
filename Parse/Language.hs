module Parse.Language where

import Text.Parsec
import qualified Text.Parsec.Token as T
import qualified Text.Parsec.Language as L

import Parse.SourceCharacter (sourceCharacter)

ecma6Def = L.emptyDef
    { T.commentStart = "/*"
    , T.commentEnd = "*/"
    , T.commentLine = "//"
    , T.nestedComments = True
    , T.identStart = letter <|> char '_'
    , T.identLetter = sourceCharacter
    , T.caseSensitive = True
    }

lexer = T.makeTokenParser ecma6Def

identifier = T.identifier lexer
reserved = T.reserved lexer
operator = T.operator lexer
reservedOp = T.reservedOp lexer
charLiteral = T.charLiteral lexer
stringLiteral = T.stringLiteral lexer

symbol = T.symbol lexer
lexeme = T.lexeme lexer
