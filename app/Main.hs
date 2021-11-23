module Main where

import System.IO

import Args
import Compiler

main :: IO ()
main = do
  parsedArgs <- getOpts 
  putStrLn "=== Parsed args: ==="
  print parsedArgs

  putStrLn "=== Input: ==="
  input <- readInput $ inputLocation parsedArgs
  putStrLn input

  let output = compileAll input
  printMaybe $ errors output
  putStrLn $ "Compilation Summary:\n" ++ compilationSummary output ++ "\n"
  printOutput (outputLocation parsedArgs) $ compiledCode output
  
printMaybe :: Maybe String -> IO ()
printMaybe = maybe (return ()) putStrLn

printOutput :: OutputLocation -> String -> IO ()
printOutput OLStdout = putStrLn
printOutput (OLFile path) = writeFile path

readInput :: InputLocation -> IO String
readInput (ILFile path) = readFile path
readInput ILStdin = getContents