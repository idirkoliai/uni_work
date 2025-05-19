import           Data.List


--
-- Exercice 1
--


properFactors :: Int -> [Int]
properFactors x = init (filter (\l -> (mod l x) /= 0) [0..x])


-- perfects :: Int -> [Int]

--fizzBuzz :: [String]
--fizzBuzz = 

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN],z<x,y/=x || y/=z]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p xs = if p (head xs) == True then True else any' p (tail xs)

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p xs = foldr p xs

--group' :: Eq a => [a] -> [[a]]
--group' [] = []
--group' (x:xs)
--    | x == head xs = x : group' xs
--    | otherwise = [] : group' xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p x0 = x0 : while p f (f x0)
    | otherwise = []

--syracuse :: Int -> [Int]
--syracuse x
--    | even x = x/2 : while (> 1) syracuse (x/2)
--    | odd x = x*3+1 : while (> 1) syracuse (x*3+1)

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0
    | k > 0 = x0 : loop (k-1) f (f x0)
    | otherwise = []

--
-- Exercice 3

--cycle' :: [a] -> [a]
--cycle' x = x : cycle' x

--
-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
