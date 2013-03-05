{-# LANGUAGE ExistentialQuantification #-}

-- Try doing this with Template Haskell
-- Try doing this with the Endo Writer monad: http://ocharles.org.uk/blog/posts/2013-02-12-quick-dsls-with-endo-writers.html

module Schedule where

import Control.Monad (forM_)
import Data.List (partition)

import Lister

data Schedule = Schedule [Meeting]
data Meeting  = Meeting [Section] Month Int Integer
data Section  = Section Float [Integer] [String] [String]
data Note     = Note String
              | Problem String
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
section number notes = record $ Section number exerciseNumbers texts problems
  where texts                  = map (\(Note s) -> s)     (extractNotes     notes)
        exerciseNumbers        = map (\(Exercise n) -> n) (extractExercises notes)
        problems               = map (\(Problem p) -> p)  (extractProblems  notes)

exercises :: [Integer] -> Lister Note ()
exercises problems = forM_ problems (record . Exercise)

note :: String -> Lister Note ()
note string = record $ Note string

problem :: String -> Lister Note ()
problem string = record $ Problem string

isNote :: Note -> Bool
isNote (Note _) = True
isNote _        = False

isExercise :: Note -> Bool
isExercise (Exercise _) = True
isExercise _            = False

isProblem :: Note -> Bool
isProblem (Problem _) = True
isProblem _           = False

extractNotes :: Lister Note b -> [Note]
extractNotes = fst . partition isNote . extract

extractExercises :: Lister Note b -> [Note]
extractExercises = fst . partition isExercise . extract

extractProblems :: Lister Note b -> [Note]
extractProblems = fst . partition isProblem  . extract
