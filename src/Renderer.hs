import Markup
import Schedule

main :: IO ()
main = renderSchedule $ do
  meeting February 20 2013 $ do
    reading   3.1
    exercises 3.1 [5, 8, 16]

    reading   3.2
    exercises 3.2 [1, 5, 12]

    reading   3.3
    exercises 3.3 [4, 10, 25]

  meeting February 27 2013 $ do
    reading   3.4
    exercises 3.4 [4, 18, 29]
