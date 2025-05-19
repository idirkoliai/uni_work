import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
-- properFactors x = [y | y <- x/y == x `div` y]

-- perfects :: Int -> [Int]
-- perfects x = [y | x <- [0..x], z <- sum(properFactors x) == y]

-- fizzBuzz :: [String]
-- fizzBuzz x = []


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
-- any' p xs = any' p x:xs

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]
-- syracuse x while x <> 1
--    even x = 


-- loop :: Int -> (a -> a) -> a -> [a], Int



--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]



-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]
-- select xs = 

-- partitions :: [a] -> [[[a]]]



--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a, b) (c, d) = (b > c) && (a < d)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [is] = True
-- unitI [(a, b), (c, d)] = 



-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
