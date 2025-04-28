import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors xs = [i | i <- [1..xs - 1], xs `mod` i == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

--fizzBuzz :: [String]




altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, (even x && even y && odd z) || (even x && odd y && odd z) || (odd x && odd y && even z) || (odd x && even y && odd z) || (even x && odd y && even z) || (odd x && even y && even z)]




--
-- Exercice 2
--

--any' :: (a -> Bool) -> [a] -> Bool


-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

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
sublists 0 [] = [[]]
sublists _ [] = []
sublists k (x:xs)
    | k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs

--select :: [a] -> [(a, [a])]



--partitions :: [a] -> [[[a]]]



--
-- Exercice 4
--

first :: (Int, Int) -> Int
first (x, _) = x

second :: (Int, Int) -> Int
second (_, y) = y

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI x y = (first x < first y && first y < second x) || (first x < second y && second y < second x) || (first x > first y && first x < second y) || (second x > first y && second x < second y)

--unitI :: [(Int, Int)] -> Bool


--isLeftSortedI :: [(Int, Int)] -> Bool


-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
