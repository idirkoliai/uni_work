import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors a = filter (\x -> a `mod` x == 0) [1..a-1]

perfects :: Int -> [Int]
perfects a = filter (\x ->  sum (properFactors(x)) == x) [1..a-1]



-- fizzBuzz :: [String]
fizzBuzz [a] = (show  [a]::[Int]) 



-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (x,y) = (\z -> [a..b] `elem`[x..y]) 

-- unitI :: [(Int, Int)] -> Bool


-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
