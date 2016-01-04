module AST.Literal where

data Literal
    = Null
    | Boolean BooleanLiteral
    | Numeric Number
    | String String
    | RegExp RegExp
    | Template
    deriving (Show, Eq)

data BooleanLiteral = True | False deriving (Show, Eq)

type Number = Double

data RegExp = R String String deriving (Show, Eq)
