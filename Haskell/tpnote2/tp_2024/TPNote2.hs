-----------------------------------------------------

-- TP note - L3 - 28 mai 2024
-- NOM Prenom

-----------------------------------------------------

import Data.List
import Data.Maybe
import Data.Ord (comparing)

-----------------------------------------------------

--
-- Exercice 1 - Listes symétriques
--

type Nat = Int

newtype SymList a = SymList ([a], [a])

instance (Show a) => Show (SymList a) where
  show = show . fromSL

instance (Eq a) => Eq (SymList a) where
  xs == ys = fromSL xs == fromSL ys

instance (Ord a) => Ord (SymList a) where
  xs `compare` ys = fromSL xs `compare` fromSL ys

instance Functor SymList where
  fmap f (SymList (xs, ys)) = SymList (fmap f xs, fmap f ys)

-- Empty symmetric list
nilSL :: SymList a
nilSL = SymList ([], [])

-- Test empty symmetric list
nullSL :: SymList a -> Bool
nullSL (SymList ([], [])) = True
nullSL _ = False

-- Abstraction
fromSL :: SymList a -> [a]
fromSL (SymList (xs, ys)) = xs ++ reverse ys

-- Test invariant 1
testInv1 :: SymList a -> Bool
testInv1 (SymList ([], ys)) = length ys <= 1
testInv1 _ = True

-- Test invariant 2
testInv2 :: SymList a -> Bool
testInv2 (SymList (xs, [])) = length xs <= 1
testInv2 _ = True

-- Test invariant 1 && invariant 2
testInvs :: SymList a -> Bool
testInvs sl = testInv1 sl && testInv2 sl

-- 1.a
-- singleSL :: SymList a -> Bool

-- 1.b
-- lengthSL :: SymList a -> Nat

-- 1.c
-- consSL :: a -> SymList a -> SymList a

-- 1.d
-- snocSL :: a -> SymList a -> SymList a

-- 1.e
-- toSL :: [a] -> SymList a

-- 1.f
-- headSL :: SymList a -> Maybe a

-- 1.g
-- lastSL :: SymList a -> Maybe a

-- 1.h
-- tailSL :: SymList a -> Maybe (SymList a)

-- 1.i
-- initSL :: SymList a -> Maybe (SymList a)

-- 1.j
-- takeWhileSL :: (a -> Bool) -> SymList a -> SymList a
-- dropWhileSL :: (a -> Bool) -> SymList a -> SymList a

-----------------------------------------------------

--
-- Exercice 2 - Listes
--

-- 2.a
undigits :: [Integer] -> Integer
undigits [] = 0
undigits xs = foldl (\acc x -> acc * 10 + x) 0 xs

-- 2.b
sortOddsOnly :: [Int] -> [Int]
sortOddsOnly xs = sorted xs odds
  where
    odds = sort $ filter odd xs
    sorted [] os = os
    sorted xs [] = xs
    sorted (x : xs) (o : os)
      | odd x = o : sorted xs os
      | otherwise = x : sorted xs (o : os)

-- 2.c
intCompositions :: Int -> [[Int]]
intCompositions 0 = []
intCompositions 1 = [[1]]
intCompositions n = [n] : [e : sb | e <- [n - 1, n - 2 .. 1], sb <- intCompositions (n - e)]

-- 2.d
generate :: Int -> Int -> [[Int]]
generate n 1 = [[n] | n < 10]
generate n k = filter (\xs -> length xs == k && xs == sort xs) $ intCompositions n

findAll :: Int -> Int -> Maybe (Int, Int, Int)
findAll n k = process n k
  where
    xs = map (undigits . map toInteger) $ generate n k
    process n k
      | null xs = Nothing
      | otherwise = Just (length xs, fromInteger $ minimum xs, fromInteger $ maximum xs)

-- 2.e
-- conway :: [String]

-----------------------------------------------------

--
-- Exercice 3 - Chiffrement
--

-- 3.a
railFenceSeq :: Int -> [Int]
railFenceSeq 1 = repeat 1
railFenceSeq n = [1 .. n] ++ [(n - 1), (n - 2) .. 2] ++ railFenceSeq n

-- 3.b
sortAccordingTo :: (Ord a) => [b] -> [a] -> [b]
sortAccordingTo xs ys = map fst $ sortBy (comparing snd) $ zip xs ys

-- 3.c
code :: Int -> [a] -> [a]
code k str = sortAccordingTo str $ railFenceSeq k

-- 3.d
-- decode :: Int -> [a] -> [a]

-----------------------------------------------------
