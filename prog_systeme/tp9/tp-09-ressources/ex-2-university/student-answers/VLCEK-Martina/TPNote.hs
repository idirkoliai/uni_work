import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1] , (mod) n x == 0]


perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]


--fizzBuzz :: [String]
--fizzBuzz = [x | if ((mod) x 3 == 0) then "fizz" else if((mod) x 5 == 0) then "buzz", show x]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, even x /= even y || even x /= even z || even y /= even z]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x : xs) = if p x then True else any' p xs 


--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p 


--group' :: Eq a => [a] -> [[a]]
--group' [] = []
--group' (x : xs)

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = filter (p x0) 
--while p f x0 = [x0] ++ while p f x0

syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse a = if even a then [a] ++ syracuse ((div) a 2) else [a] ++ syracuse (a * 3 + 1)

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs = xs ++ cycle' xs


--borders :: (Eq a) => [a] -> [[a]]


--sublists :: Int -> [a] -> [[a]]
--sublists 0 xs = [[]]
--sublists a xs = [(x : xss) | x  <- xs, length (x : xss) == a]


--select :: [a] -> [(a, [a])]
--select [] = []
--select xs = [()]


-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool


-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
