import Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum(properFactors x) == x]

--fizzBuzz :: [String]
--fizzBuzz = [x | x <- [1..], x `mod` 3 = "fizz", x `mod` 5 = "buzz", (x `mod` 3 && x `mod` 5) = "fizzbuzz"]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, (even x && even y && odd z) || (even x && even z && odd y) || (even z && even y && odd x) || (odd x && odd y && even z) || (odd x && odd z && even y) || (odd z && odd y && even x)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr f False xs
  where
    f x b = p x || b

group' :: Eq a => [a] -> [[a]]
group' (x:xs) = go [x] xs
  where
    go current [] = [current]
    go current (y:ys)
      | y == last current = go(current ++ [y]) ys
      | otherwise = current : go [y] ys

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
sublists _ [] = [[]]
sublists 0 _ = [[]]
sublists k xs = take k xs : sublists k (drop k xs)

select :: [a] -> [(a, [a])]
select [] = []

partitions :: [a] -> [[a]]
partitions [] = [[]]
partitions (x:xs) = (x:xs) : map (x:) (partitions xs)


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, x1') (x2, x2') = (x2 <= x1 && x2' >= x1 && x2' <= x1') || (x2 >= x1 && x2' >= x1' && x2 <= x1') || (x2 >= x1 && x2' >= x1') || (x1 <= x2 && x1' >= x2 && x1' <= x2') || (x1 >= x2 && x1' >= x2' && x1 <= x2') || (x1 >= x2 && x1' >= x2') 

unitI :: [(Int, Int)] -> Bool
unitI [] = True

--isLeftSortedI :: [(Int, Int)] -> Bool

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1, x1') (x2, x2') 
  | x2 < x1 && x2' < x1' = (x2, x1')
  | x2 < x1 && x2' < x1 = (x2', x1')
  | (x1 < x2 && x1' < x2') || (x1 < x2 && x1' < x2) = (x1, x2')
  | otherwise = (x1, x2')

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
