{-# LANGUAGE OverloadedStrings #-}

module Markup where

import Prelude hiding (head, div, id, span)

import Text.Blaze (ToMarkup, toMarkup)
import Text.Blaze.Html.Renderer.Pretty (renderHtml)
import Text.Blaze.Html5.Attributes     (class_, href, src, rel, id)
import Text.Blaze.Html5                (Html, (!), toHtml, docTypeHtml, head, title, body, p, ul, ol, li, div, h1, h2, h3, h4, img, link, a, span)

import qualified Text.Blaze.Html5 as Html5

import Control.Monad (forM_, when)

import Data.List (intercalate)

import Schedule
import Lister

instance ToMarkup Schedule where
  toMarkup (Schedule meetings) =
    docTypeHtml $ do
      head $ do
        title "Proof Club Schedule"
        link ! rel "stylesheet" ! href "/css/reset.css"
        link ! rel "stylesheet" ! href "/css/fonts.css"
        link ! rel "stylesheet" ! href "/css/application.css"

      body $ do
        div ! id "content" $ do
          Html5.section ! class_ "title" $ do
            div $ do
              h1 "Proof Club"

          Html5.section ! class_ "book" $ do
            div $ do
              h2 "How to Prove It"
              a ! href "http://www.amazon.com/How-Prove-It-Structured-Approach/dp/0521675995/ref=dp_ob_title_bk" $ do
                img ! src "http://www.ebook3000.com/upimg/201004/21/211706562277.jpeg"
              p "Geared to preparing students to make the transition from solving problems to proving theorems, this text teaches them the techniques needed to read and write proofs. The book begins with the basic concepts of logic and set theory, to familiarize students with the language of mathematics and how it is interpreted. These concepts are used as the basis for a step-by-step breakdown of the most important techniques used in constructing proofs. To help students construct their own proofs, this new edition contains over 200 new exercises, selected solutions, and an introduction to Proof Designer software. No background beyond standard high school mathematics is assumed."

          Html5.section ! class_ "schedule" $ do
            div $ do
              h3 "Schedule"
              ul $ forM_ meetings $ toMarkup

instance ToMarkup Meeting where
  toMarkup (Meeting sections month day year) =
    li ! class_ "meeting" $ do
      h4  $ toMarkup $ show month ++ " " ++ show day ++ ", " ++ show year
      ul  $ forM_ sections toHtml

instance ToMarkup Section where
  toMarkup (Section number exercises notes problems) = li $ do
    h4 $ toMarkup ("Section " ++ show number)
    when (not $ null exercises) $ do
      span "ex."
      span ! class_ "exercises" $ toHtml $ intercalate ", " (map show exercises)
    div ! class_ "notes" $ do
      forM_ notes (span . toHtml)
    ol ! class_ "problems" $ do
      forM_ problems (li . toHtml)

renderSchedule :: Lister Meeting () -> IO ()
renderSchedule = putStrLn . renderHtml . toHtml . schedule

commaList :: (Show a) => [a] -> Html
commaList = toHtml . (intercalate ", ") . (map show)
