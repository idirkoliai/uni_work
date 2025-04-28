import Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
-- properFactors n = [x, (rem n x )== 0 && x /= n ]

-- perfects :: Int -> [Int]
-- perfects n = [x, perfect x && x < n]
--     where
--     perfects Int -> Int
--     perfects n = 

-- fizzBuzz :: [String]
-- fizzBuzz = [1..]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
-- altParity3 n p = [(x,y,z), (z < x) && (y /= x || y /= z) && (n < x && x < p) && (n < y && y < p) && (n < z && z < p) && (even x /= even y || even x /= even z)]

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
-- any' f xs = 

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
-- while p f x0 =  filter p [x | f x0]

-- syracuse :: Int -> [Int]
-- syracuse n = while((\x <- x /= 1) (nextSyracuse) n)
--     where
--     nextSyracuse Int -> Int
--     nextSyracuse n
--     | even n = n / 2
--     | otherwise = n * 3 + 1

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0
 | k == 0 = []
 | otherwise = loop (k - 1) f (f x0)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
-- cycle' xs = [x..x | x <- xs]

-- borders :: (Eq a) => [a] -> [[a]]
-- borders xs = [x | x <-xs , ]

-- sublists :: Int -> [a] -> [[a]]
-- sublists k xs = [[x]]

-- select :: [a] -> [(a, [a])]
-- select xs
--  | xs == [] = []
--  | otherwise = [x : xs]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
-- intersectI i1 i2
--  | (i1[1] > i2[0] && i1[0] < i2[1]) || (i2[1] > i1[0] && i2[0] < i1[1]) = True
--  | otherwise = False

-- unitI :: [(Int, Int)] -> Bool
-- unitI is = filter(\i <- is, i[0])

-- isLeftSortedI :: [(Int, Int)] -> Bool
-- isLeftSortedI is = False

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
-- cover i1 i2 
--  | i1[0] < i2[0] && i1[1] < i2[1] = (i1[0], i2[1])
--  | .....

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
-- coversLeftSortedI is 
