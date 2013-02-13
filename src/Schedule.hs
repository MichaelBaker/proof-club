{-# LANGUAGE ExistentialQuantification #-}

-- Try doing this with Template Haskell
-- Try doing this with the Endo Writer monad: http://ocharles.org.uk/blog/posts/2013-02-12-quick-dsls-with-endo-writers.html

module Schedule where

import Lister

data Schedule = Schedule [Meeting]
data Meeting  = Meeting [Activity] Month Int Integer
data Activity = Reading Float
              | Exercises Float [Integer] deriving (Show)
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

meeting :: Month -> Int -> Integer -> Lister Activity () -> Lister Meeting ()
meeting month day year list = record $ Meeting (extract list) month day year

reading :: Float -> Lister Activity ()
reading section = record $ Reading section

exercises :: Float -> [Integer] -> Lister Activity ()
exercises section problems = record $ Exercises section problems
