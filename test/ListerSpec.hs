import Test.Hspec
import Lister

main = hspec $ do
  describe "The Lister Monad" $ do
    context "return" $ do
      it "starts with an empty list" $ do
        return 5 `shouldBe` Lister ([] :: [Int]) 5

    context ">>=" $ do
      it "makes the previous value available" $ do
        (Lister [1] "nowp" >>= (\string -> Lister [5] string)) `shouldBe` Lister [1, 5] "nowp"

    context ">>" $ do
      it "combines the lists" $ do
        (Lister [1] () >> Lister [2] ()) `shouldBe` Lister [1, 2] ()

      it "returns the value of the second Lister" $ do
        (Lister [1] "Ohai" >> Lister [2] "kbye") `shouldBe` Lister [1, 2] "kbye"

    context "extract" $ do
      it "makes the current list available" $ do
        extract (Lister [1] "thingy") `shouldBe` [1]

    context "record" $ do
      it "places an item in the list" $ do
        Lister [1, 2] () `shouldBe` do
          record 1
          record 2
