module Args (getOpts, Target, OutputLocation(..), InputLocation(..), ParsedArgs(..)) where

import Data.Functor
import System.FilePath (FilePath)

import Options.Applicative
import Options.Applicative.Types

-- | use to create a flag on by default; and combine it later
noopFlag :: a -> Mod FlagFields a -> Parser a
noopFlag x = flag x x

data Target = Tx86_64 deriving Show

x86_64Str :: String
x86_64Str = "x86_64"

data OutputLocation 
  = OLStdout
  | OLFile FilePath
  deriving Show

data InputLocation
  = ILStdin
  | ILFile FilePath
  deriving Show

data ParsedArgs = ParsedArgs
  { target :: Target
  , inputLocation :: InputLocation
  , outputLocation :: OutputLocation
  } deriving Show

fileInput :: Parser InputLocation
fileInput = ILFile <$> strOption
  (  long "input-file"
  <> short 'i'
  <> metavar "INPUT-FILENAME"
  <> help "Input file" )

stdInput :: Parser InputLocation
stdInput = noopFlag ILStdin
  (  long "stdin"
  <> help "Read from stdin" )

fileOutput :: Parser OutputLocation
fileOutput = OLFile <$> strOption
  (  long "out-file"
  <> short 'o'
  <> metavar "OUTPUT-FILENAME"
  <> help "Output file" )

stdOutput :: Parser OutputLocation
stdOutput = noopFlag OLStdout
  (  long "stdout"
  <> help "Write to stdout" )

optOutLoc :: Parser OutputLocation
optOutLoc = fileOutput <|> stdOutput

optInLoc :: Parser InputLocation
optInLoc = fileInput <|> stdInput

optTarget :: Parser Target
optTarget = option
  ( eitherReader reader )
  (  long "target"
  <> short 't'
  <> metavar "TARGET"
  <> value Tx86_64
  <> showDefault
  <> help "Input file" ) 
  where
    reader str
      | str == x86_64Str = Right Tx86_64
      | otherwise = Left "No supported targets except x86_64"


optParser :: Parser ParsedArgs
optParser = ParsedArgs
  <$> optTarget <*> optInLoc <*> optOutLoc

opts :: ParserInfo ParsedArgs
opts = info (optParser <**> helper)
  ( fullDesc
  <> progDesc "A helpful Metal compiler"
  <> header "???"
  )

getOpts :: IO ParsedArgs
getOpts = execParser opts