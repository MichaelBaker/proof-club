{-# LANGUAGE ExistentialQuantification #-}

-- Try doing this with Template Haskell
-- Try doing this with the Endo Writer monad: http://ocharles.org.uk/blog/posts/2013-02-12-quick-dsls-with-endo-writers.html

module Schedule where

import Control.Monad (forM_)
import Data.List (partition)

import Lister

data Schedule = Schedule [Meeting]
data Meeting  = Meeting [Section] Month Int Integer
data Section  = Section Float [Integer] [String]
data Note     = Note String
              | Exercise Integer
data Month    = January
              | February
              | March
              | April
              | May
              | June
              | July
              | August
              | September
              | October
              | November
              | December deriving (Show)


schedule :: Lister Meeting () -> Schedule
schedule list = Schedule (extract list)

meeting :: Month -> Int -> Integer -> Lister Section () -> Lister Meeting ()
meeting month day year list = record $ Meeting (extract list) month day year

section :: Float -> Lister Note () -> Lister Section ()
section number notes = record $ Section number exerciseNumbers texts
  where (textNotes, exercises) = partition isNote (extract notes)
        texts                  = map (\(Note s) -> s)     textNotes
        exerciseNumbers        = map (\(Exercise n) -> n) exercises

exercises :: [Integer] -> Lister Note ()
exercises problems = forM_ problems (record . Exercise)

note :: String -> Lister Note ()
note string = record $ Note string

isNote :: Note -> Bool
isNote (Note _) = True
isNote _        = False
