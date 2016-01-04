{-# LANGUAGE Rank2Types, FlexibleContexts #-}
module Parse.Helpers where

import Text.Parsec
import Data.Functor.Identity (Identity)

type Parser a = ParsecT String () Identity  a

