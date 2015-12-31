module Main where

import Parse.Ecma6 as PE
import System.Environment (getArgs)

main = do
    xs <- getArgs
    case xs of
        [] -> do
            putStrLn "No input file given"
        fileName:_ -> do
            putStrLn fileName
            parseFile fileName

parseFile :: FilePath -> IO ()
parseFile fileName = do
    fileContent <- readFile fileName
    let parseResult = PE.parseEcma6 fileContent
    case parseResult of
        Right result -> mapM_ putStrLn result
        Left error -> putStrLn $ show error
