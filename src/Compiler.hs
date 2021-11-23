module Compiler
    ( compileAll
    , CompilerOutput(..)
    ) where

data CompilerOutput = CompilerOutput
    { compiledCode :: String
    , compilationSummary :: String
    , errors :: Maybe String}

compileAll :: String -> CompilerOutput
compileAll input = CompilerOutput "this is not yet code" "nothing was compiled" Nothing
