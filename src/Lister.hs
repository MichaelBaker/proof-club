module Lister where

data Lister a b = Lister [a] b deriving (Eq, Show)

extract :: Lister a b -> [a]
extract (Lister list _) = list

record :: a -> Lister a ()
record a = Lister [a] ()

instance Monad (Lister a) where
  return a = Lister [] a
  (Lister listA _) >> (Lister listB value) = Lister (listA ++ listB) value
  original@(Lister list value) >>= f = original >> f value
