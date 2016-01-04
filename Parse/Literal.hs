module Parse.Literal where

import Text.Parsec

import Parse.Language
import Parse.Helpers

import qualified AST.Literal as AST

nullLiteral :: Parser AST.Literal
nullLiteral = symbol "null" >> return AST.Null

boolLiteral :: Parser AST.Literal
boolLiteral = AST.Boolean <$> (trueLit <|> falseLit)
    where
        trueLit = symbol "true" >> return AST.True
        falseLit = symbol "false" >> return AST.False
