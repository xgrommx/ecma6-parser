module Parse.Literal where

import Text.Parsec
import qualified Text.Parsec.Char as C
import qualified Data.Char as DC
import qualified Data.Maybe as DM
import qualified Data.List as DL

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

numericLiteral :: Parser AST.Literal
numericLiteral =
    AST.Numeric <$> (decimalLiteral
                <|> binaryLiteral
                <|> octalLiteral
                <|> hexLiteral)



decimalLiteral :: Parser AST.Number
decimalLiteral = whiteSpace >> (gte1 <|> lt1 <|> noDecimalPoint)

noWsDecimal :: Parser Double
noWsDecimal = do
    cs <- many (C.oneOf "0123456789")
    return (dec2dec cs)
    where
        dec2dec = foldr  (\c s -> s*10 + c) 0 . reverse . map c2d

gte1 = do
    characteristic <- noWsDecimal
    char '.'
    mantissa <- option 0 noWsDecimal
    let fractional = num2frac mantissa
    exp <- exponentPart
    return ((mantissa + fractional) ** exp)


lt1 = do
    char '.'
    mantissa <- noWsDecimal
    exp <- exponentPart
    return ((num2frac mantissa) ** exp)


noDecimalPoint :: Parser AST.Number
noDecimalPoint = do
    characteristic <- noWsDecimal
    exp <- option 1 exponentPart
    return (characteristic ** exp)

exponentPart :: Parser Double
exponentPart = do
    char 'e' <|> char 'E'
    fromIntegral <$> integer

binaryLiteral :: Parser AST.Number
binaryLiteral = do
    whiteSpace
    char '0'
    char 'b' <|> char 'B'
    bs <- many1 (char '0' <|> char '1')
    return (bin2dec bs)
    where
        bin2dec :: [Char] -> Double
        bin2dec = foldr  (\c s -> s*2 + c) 0 . reverse . map c2d

octalLiteral :: Parser AST.Number
octalLiteral = fromIntegral <$> octal

hexLiteral :: Parser AST.Number
hexLiteral = fromIntegral <$> hexadecimal

num2frac :: Double -> Double
num2frac 0 = 0
num2frac n = n / (10.0 ** (fromIntegral . ceiling $ logBase 10.0 n))

c2d :: Char -> Double
c2d c = fromIntegral $ DM.fromMaybe (error $ "illegal char " ++ [c]) (DL.elemIndex c "0123456789ABCDEF")
