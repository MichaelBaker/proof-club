import Markup
import Schedule

main :: IO ()
main = renderSchedule $ do
  meeting February 20 2013 $ do
    section 3.1 $ do
      note      "Assume the hypothesis."
      note      "Prove the contrapositive."
      exercises [5, 8, 16]

    section 3.2 $ do
      note      "Proof by contradiction."
      note      "Negative conclusions."
      note      "Re-express negatives as positives."
      exercises [1, 5, 12]

    section 3.3 $ do
      exercises [4, 10, 25]

  meeting February 27 2013 $ do
    section 3.4 $ do
      exercises [4, 18, 29]
