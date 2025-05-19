import Data.List
import System.Posix (sleep)

-- Exercice 1 : Compréhensions de listes

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1 .. (n `div` 2)], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1 .. n], (sum . properFactors) x == x]

fizzBuzz :: [String]
fizzBuzz = [process x | x <- [1 ..]]
  where
    process x
      | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
      | x `mod` 3 == 0 = "fizz"
      | x `mod` 5 == 0 = "buzz"
      | otherwise = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 from to =
  [(x, y, z) | x <- [from .. to], y <- [from .. to], z <- [from .. (x - 1)], y /= x || y /= z, not (x `mod` 2 == y `mod` 2 && y `mod` 2 == z `mod` 2)]

-- Exercice 2 : Fonctions d’ordre supérieur

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> p x || acc) False

group' :: (Eq a) => [a] -> [[a]]
group' (x : xs) = go xs [x]
  where
    go [] acc = [acc]
    go (x : xs) acc
      | x == head acc = go xs (x : acc)
      | otherwise = acc : go xs [x]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x
  | (not . p) x = []
  | otherwise = x : while p f (f x)

syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse n
  | even n = n : syracuse (n `div` 2)
  | otherwise = n : syracuse (3 * n + 1)

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x = f x : loop (pred k) f (f x)

-- Exercice 3 : Fonctions sur les listes

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders xs = map fst $ filter (uncurry (==)) (zip (inits xs) (reverse $ tails xs))

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [] = []
sublists k (x : xs) = [x : ys | ys <- sublists (k - 1) xs] ++ sublists k xs

select :: [a] -> [(a, [a])]
select [] = []
select (x : xs) = (x, xs) : [(y, x : ys) | (y, ys) <- select xs]

-- partitions :: [a] -> [[[a]]]

-- Exercice 4 : Des intervalles

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, y1) (x2, y2) = x1 <= x2 && x2 <= y1 || x2 <= x1 && x1 <= y2

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI xs = all (== 0) $ map (\x -> x - (head distances)) distances
  where
    distances = map (\(x, y) -> x - y) xs

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = left == sort left
  where
    left = map fst xs

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1, y1) (x2, y2) = (min x1 x2, max y1 y2)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
