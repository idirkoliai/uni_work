import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]

properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]

perfects n = [x | x <- [1..n], sum ( properFactors x) == x]

-- fizzBuzz :: [String]

fizzBuzz =  map (show "fizz")[x | x <- [1..1000], x `mod` 3 == 0]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]

-- altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN],y <- [x + 1..toN], z <- [x + 2..toN], z < x, y /= x, y /=z]
--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool

any' p xs = length (filter(\x -> p x) xs) /= 0

-- any'' :: (a -> Bool) -> [a] -> Bool

-- any'' p (x:xs) = length (foldr (p) x xs) (/=) 0

-- any'' p (x:xs) = length(foldr((p x) xs)) /= 0

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- while = 
-- syracuse :: Int -> [Int]
-- syracuse n = if even n then  

-- loop :: Int -> (a -> a) -> a -> [a]

-- loop k f x0 = foldr (+) x0 [x0..k]

--
-- Exercice 3
--


-- cycle' :: [a] -> [a]

-- cycle' a = a++ cycle' a

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
-- intersectI i1 i2 = 


-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
