import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], x == (sum $ properFactors x)]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
  where
    f x
      | and [x `mod` 3 == 0, x `mod` 5 == 0] = "fizzbuzz"
      | x `mod` 3 == 0 = "fizz"
      | x `mod` 5 == 0 = "buzz"
      | otherwise = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [1..], y <- [1..], z <- [1..], fromN <= x, fromN <= y, fromN <= z, x <= toN, y <= toN, z <= toN,z < x, 
                        or [y /= x, y /= z], 
                        or [not (and [even x, even y,even z]),  not (and [odd x, odd y,odd z])]]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs)
  | p x = True
  | otherwise = any' p xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p [] = False
--any'' p xs = foldr (or) [] [p x | x <- xs]

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
  | not $ p $ f x0 = [x0]
  | otherwise = x0 : while p f (f x0)

--syracuse :: Int -> [Int]
--syracuse n = while (\x -> x /= 1) f n
--  where
--    f x
--      | x `mod` 2 == 0 = (/2)
--      | otherwise = (\x -> 3*x+1)

--loop :: Int -> (a -> a) -> a -> [a]

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' = concat . repeat

borders :: (Eq a) => [a] -> [[a]]
borders ys = [word | word <- inits ys, word `elem` inits (reverse ys)]

-- sublists :: Int -> [a] -> [[a]]

select :: Eq a => [a] -> [(a, [a])]
select [] = []
select xs = [(x, delete x xs ) | x <- xs]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1@(x, y) i2@(x', y') = or [x1 == x2 | x1 <- [x..y], x2 <- [x'..y']]

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x@(x1, x2):y@(y1, y2):xs)
  | (x2 - x1) == (y2 - y1) = unitI xs
  | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI (x:y:xs)
  | x <= y = isLeftSortedI (y:xs)
  | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x, y) (a, b) = (min x a, max y b)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
