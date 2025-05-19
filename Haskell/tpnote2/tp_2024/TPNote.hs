-----------------------------------------------------

-- TP note - L3 - 28 mai 2024
-- NOM Prenom

-----------------------------------------------------

import Data.Array.Base (newListArray)
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
singleSL :: SymList a -> Bool
singleSL (SymList ([], [_])) = True
singleSL (SymList ([_], [])) = True
singleSL _ = False

-- 1.b
lengthSL :: SymList a -> Nat
lengthSL (SymList (xs, ys)) = length xs + length ys

-- 1.c
consSL :: a -> SymList a -> SymList a
consSL x (SymList (xs@[], ys@[_])) = SymList ([x], ys)
consSL x (SymList (xs@[_], ys@[])) = SymList ([x], xs)
consSL x (SymList (xs, ys)) = SymList (x : xs, ys)

-- 1.d
snocSL :: a -> SymList a -> SymList a
snocSL x (SymList (xs@[], ys@[_])) = SymList (ys, [x])
snocSL x (SymList (xs, ys)) = SymList (xs, x : ys)

-- 1.e
toSL :: [a] -> SymList a
toSL = foldl (flip snocSL) nilSL

-- 1.f
headSL :: SymList a -> Maybe a
headSL (SymList ([], [])) = Nothing
headSL (SymList (x : xs, _)) = Just x
headSL (SymList ([], ys)) = Just $ last ys

-- 1.g
lastSL :: SymList a -> Maybe a
lastSL (SymList ([], [])) = Nothing
lastSL (SymList (_, x : xs)) = Just x
lastSL (SymList (xs, [])) = Just $ last xs

-- 1.h
tailSL :: SymList a -> Maybe (SymList a)
tailSL (SymList ([], [])) = Nothing
tailSL (SymList ([], [_])) = Just nilSL
tailSL (SymList ([_], ys)) = Just $ toSL $ reverse ys
tailSL (SymList (xs, ys)) = Just $ SymList (tail xs, ys)

-- 1.i
initSL :: SymList a -> Maybe (SymList a)
initSL (SymList ([], [])) = Nothing
initSL (SymList ([_], [])) = Just nilSL
initSL (SymList (xs, [_])) = Just $ toSL xs
initSL (SymList (xs, ys)) = Just $ SymList (xs, tail ys)

-- 1.j
takeWhileSL :: (a -> Bool) -> SymList a -> SymList a
takeWhileSL f sl
  | nullSL sl = sl
  | f h = consSL h $ takeWhileSL f $ fromJust $ tailSL sl
  | otherwise = nilSL
  where
    h = fromJust $ headSL sl

dropWhileSL :: (a -> Bool) -> SymList a -> SymList a
dropWhileSL f sl
  | nullSL sl = sl
  | f h = dropWhileSL f $ fromJust $ tailSL sl
  | otherwise = sl
  where
    h = fromJust $ headSL sl
-----------------------------------------------------

--
-- Exercice 2 - Listes
--

-- 2.a
undigits :: [Integer] -> Integer
undigits = foldl (\acc x -> acc * 10 + x) 0

-- 2.b
sortOddsOnly :: [Int] -> [Int]
sortOddsOnly [] = []
sortOddsOnly [x] = [x]
sortOddsOnly xs = newList
  where
    (od, ev) = foldr (\e@(x, pos) (ods, evs) -> if odd x then (e : ods, evs) else (ods, e : evs)) ([], []) $ zip xs [0 ..]
    sorted_odds = sort od
    newList = sorted sorted_odds ev
    sorted sorted [] = map fst sorted
    sorted [] evs = map fst evs
    sorted xs'@((o, p1) : xs) ys'@((e, p2) : ys)
      | p2 == 0 = e : sorted xs' (map (\(x, pos) -> (x, pos - 1)) ys)
      | otherwise = o : sorted xs (map (\(x, pos) -> (x, pos - 1)) ys')

-- 2.c
intCompositions :: Int -> [[Int]]
intCompositions 0 = [[]]
intCompositions 1 = [[1]]
intCompositions e = [e] : decomposition
  where
    decomposition = [x : lst | x <- reverse [1 .. e - 1], lst <- intCompositions (e - x)]

-- 2.d
generate :: Int -> Int -> [[Int]]
generate n 1 = [[n] | n < 10]
generate n k = filter (\xs -> length xs == k && xs == sort xs) $ intCompositions n

findAll :: Int -> Int -> Maybe (Int, Int, Int)
findAll n k = res
  where
    posibilities = map (undigits . map toInteger) $ generate n k
    res = process posibilities
    process posibilities
      | null posibilities = Nothing
      | otherwise = Just (length posibilities, fromInteger $ minimum posibilities, fromInteger $ maximum posibilities)

-- 2.e
-- conway :: [String]

-----------------------------------------------------

--
-- Exercice 3 - Chiffrement
--

-- 3.a
railFenceSeq :: Int -> [Int]
railFenceSeq n
  | n <= 0 = []
  | n == 1 = repeat 1
  |otherwise = [1..n-1] ++ [n,n-1..2] ++ railFenceSeq n

-- 3.b
sortAccordingTo :: Ord a => [b] -> [a] -> [b]
sortAccordingTo xs ys = map snd  res 
  where 
    res = foldr sortinsert []  (zip ys xs)
    sortinsert x [] = [x]
    sortinsert x@(pos,_) acc@(y@(pos',_):ys)
      | pos <= pos' = x : acc
      |otherwise = y : sortinsert x ys 
      
sortAccordingTo' :: Ord a => [b] -> [a] -> [b]
sortAccordingTo' xs ys =  map snd $ sortBy (comparing fst) $ zip ys xs 


-- 3.c
code :: Int -> [a] -> [a]
code n str = sortAccordingTo str (railFenceSeq n)

-- 3.d


-----------------------------------------------------
