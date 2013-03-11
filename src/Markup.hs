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
              h2 "Introduction to Mathematical Thinking"
              a ! href "http://www.amazon.com/Introduction-Mathematical-Thinking-Keith-Devlin/dp/0615653634/ref=sr_1_1?s=books&ie=UTF8&qid=1362671852&sr=1-1&keywords=introduction+to+mathematical+thinking" $ do
                img ! src "/images/intro-to-math-thinking.JPG"
              p "Mathematician Kieth Devlin wrote Introduction to Mathematical Thinking as a text to help students transition from high school style math classes to university style classes. He illustrates the style of mathematics seen in a university setting which is characterized by precise language and problem solving rather than calculation."

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
  toMarkup (Section' notes) = li $ do
    ol ! class_ "problems" $ do
      forM_ notes (li . toHtml)

instance ToMarkup Note where
  toMarkup (Note string)      = toHtml string
  toMarkup (Problem string)   = toHtml string
  toMarkup (Exercise integer) = toHtml $ show integer

renderSchedule :: Lister Meeting () -> IO ()
renderSchedule = putStrLn . renderHtml . toHtml . schedule

commaList :: (Show a) => [a] -> Html
commaList = toHtml . (intercalate ", ") . (map show)
