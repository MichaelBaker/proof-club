import Markup
import Schedule

main :: IO ()
main = renderSchedule $ do
  meeting March 6 2013 $ do
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

  meeting March 27 2013 $ do
    section' $ do
      problem "Prove that (n/(n+1))^2 approaches 1 as n approaches infinity."
      problem "Prove that for any integer n, at least one of integers n, n + 2, n + 4 is divisible by 3."
      problem "Take any triangle, connect the midpoints of each of the sides to form a new triangle in the center. You now have four triangles. Are all four of these triangles identical(they have the same angles and side lengths)?"

  meeting April 3 2013 $ do
    section' $ do
      problem "A regular polygon is a polygon where all of the angles are the same and all the side lengths are the same. What are the angles of a regular n-sided polygon?"
      problem "Let p be a prime number. Show that if p divides the product of a and b then p must divide a, b, or both."
      problem "A planar graph is a graph that can be drawn on a plane such that its edges intersect only at their endpoints. In other words, the edges do not cross. A region is an area that is completely enclosed by the edges of a graph. Show that the regions of any planar graph can be colored with no more than five colors such that no two adjacent regions share the same color."

  meeting April 10 2013 $ do
    section' $ do
      problem "If you choose one corner of a regular polygon and draw a line from that corner to every other corner, are the angles touching the original corner all the same?"
      problem "Is it true that a finite graph having exactly two verticies of odd degree must contain a path from one to the other where no vertex is touched more than once?"
      problem "Prove that if you connect the midpoints of the sides of any four sided shape you get a parallelogram. What is its area?"
