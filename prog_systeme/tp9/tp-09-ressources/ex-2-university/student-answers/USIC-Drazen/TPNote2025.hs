import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = []

perfects :: Int -> [Int]
perfects n = []

-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- en supposant que while marche
--syracuse :: Int -> [Int]
--syracuse n = while (n < 1) (if even n then pair else impair)
--    where 
--        pair = div n 2
--        impair = (n * 3) + 1

-- loop :: Int -> (a -> a) -> a -> ([a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = x ++ cycle' x

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

select :: [a] -> [(a, [a])]
select [] = []

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d) = if c < b && c > a then True else if d > a && d < b then True else if b > c && b < d then True else if a < c && a > d then True else False

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
