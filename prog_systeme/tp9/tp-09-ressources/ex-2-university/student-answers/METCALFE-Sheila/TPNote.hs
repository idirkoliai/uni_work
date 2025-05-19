import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n], x /= n, (n `mod` x) == 0] 


perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum(properFactors x) == x ]

--fizzBuzz :: [String]
--fizzBuzz n = [x | x <- [1..n], if (3 `mod` x) == 0 && (5 `mod` x) == 0 then "fizzbuzz" else if (3 `mod` x) == 0 then "fizz" else if (5 `mod` x) == 0 then "buzz" else show x]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN],  z < x, y /= x || y /= z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = if f x then True else any' f xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f x = foldr(\x acc -> f x) False

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr(\x acc -> if x == succ x then x:acc else acc) 

--while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f xO = xO : loop (k-1) f xO

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = x ++ cycle' x 

--borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
sublists 0 xs = [[]]
sublists _ [] = []
--sublists k (x:xs) = x : sublists k xs

select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = (x, xs') : select xs
  where xs' = delete x xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
