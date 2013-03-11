import Markup
import Schedule

main :: IO ()
main = renderSchedule $ do
  meeting February 27 2013 $ do
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

  meeting March 6 2013 $ do
    section 3.4 $ do
      exercises [4, 18, 29]

    section' $ do
      problem   "How would you show that not every number of the form N = (p1*p2*p3*...*pn) + 1 is prime, where p1, p2, p3, ..., pn, is the list of all prime numbers?"

    section' $ do
      problem "Show that if every even natural number greater than 2 is the sum of two primes, then every odd natural number greater than 5 is the sum of three primes."

    section' $ do
      problem "Prove that the square root of 3 is irrational."
      problem "Is it true that the square root of N is irrational for every natural number N?"
      problem "If not, then for what N is the square root of N irrational? Formulate and prove a result of the form 'The square root of N is irrational if and only if ...'."

  meeting March 14 2013 $ do
    section' $ do
      problem "Using induction, prove that (n + 1)! > 2^(n+3) where n >= 5."
      problem "A mathematician arrives at a hotel without a reservation. This hotel has an infinite number of rooms, which are labeled with the natural numbers 1, 2, 3.... When the mathematician asks the clerk to book a reservation, the clerk responds \"I'm sorry, but all of our rooms are taken.\" Devise a plan to free a room for the mathematician without ejecting any of the current guests from the hotel."
      problem "Prove that (1/n) approaches 0 as n approaches infinity."
