{-# LANGUAGE FlexibleContexts #-}
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
    , T.identStart = letter <|> char '_' <|> char '$'
    , T.identLetter = alphaNum <|> char '_' <|> char '$'
    , T.caseSensitive = True
    , T.reservedNames = reservedWords
    }

reservedWords = 
    [ "break",  "do",  "in", "typeof"
    , "case", "else", "instanceof", "var"
    , "catch", "export", "new", "void"
    , "class", "extends", "return", "while"
    , "const", "finally", "super", "with"
    , "continue", "for", "switch", "yield"
    , "debugger", "function", "this"
    , "default", "if", "throw"
    , "delete", "import", "try"
    , "let", "static", "enum", "await"
    , "implements", "pacakge", "protected"
    , "interface", "private", "public"
    ]

reservedOperators =
    [ "..."
    , "<", ">", "<=", ">=", "==", "!=", "===", "!=="
    , "+", "-", "*", "%", "/"
    , "++", "--"
    , "<<", ">>", ">>>", "&", "|", "^"
    , "!", "~", "&&", "||", "?", ":"
    , "=", "+=", "-=", "*=", "%=", "<<=", ">>=", ">>>=", "&=", "|=", "^=", "/="
    , "=>"]

lexer = T.makeTokenParser ecma6Def

identifier = T.identifier lexer
reserved = T.reserved lexer
operator = T.operator lexer
reservedOp = T.reservedOp lexer
charLiteral = T.charLiteral lexer
stringLiteral = T.stringLiteral lexer

braces = T.braces lexer
brackets = T.brackets lexer
parens = T.parens lexer

semi = T.semi lexer
comma = T.comma lexer
dot = T.dot lexer
semiSep = T.semiSep lexer
semiSep1 = T.semiSep1 lexer
commaSep = T.commaSep lexer
commaSep1 = T.commaSep1 lexer

whiteSpace = T.whiteSpace lexer
symbol = T.symbol lexer
lexeme = T.lexeme lexer
