module AST.Literal where

data Literal
    = Null
    | Boolean BooleanLiteral
    | Numeric Double
    deriving (Show, Eq)

data BooleanLiteral = True | False deriving (Show, Eq)
