{-# LANGUAGE OverloadedStrings #-}

module Markup where

import Prelude hiding (head, div)

import Text.Blaze (ToMarkup, toMarkup, dataAttribute)
import Text.Blaze.Html5                (Html, (!), toHtml, docTypeHtml, head, title, body, p, ul, li, div, h1)
import Text.Blaze.Html.Renderer.Pretty (renderHtml)
import Text.Blaze.Html5.Attributes     (class_)
import Control.Monad (forM_)
import Data.List (intercalate)

import Schedule
import Lister

instance ToMarkup Meeting where
  toMarkup (Meeting activities month day year) =
    li ! class_ "meeting" $ do
      div ! class_ "date" $ do
        toMarkup $ show month ++ " " ++ show day ++ ", " ++ show year
      ul $ forM_ activities toHtml

instance ToMarkup Activity where
  toMarkup (Reading section) = li ! class_ "activity" $ do
    toMarkup $ "Read section " ++ show section
  toMarkup (Exercises section exercises) = li ! class_ "activity" $ do
    toMarkup $ "Exercises for section " ++ show section ++ ": " ++ commaList exercises

instance ToMarkup Schedule where
  toMarkup (Schedule meetings) =
    docTypeHtml $ do
      head $ do
        title "Proof Club Schedule"
        body $ do
          div ! class_ "schedule" $ do
            h1 "Proof Club"
            ul $ forM_ meetings $ toMarkup

renderSchedule :: Lister Meeting () -> IO ()
renderSchedule = putStrLn . renderHtml . toHtml . schedule

commaList :: (Show a) => [a] -> String
commaList = (intercalate ", ") . (map show)
