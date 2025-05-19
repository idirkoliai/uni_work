import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [xs | xs <- [1..n-1], n `mod` xs == 0]



perfects2 :: Int -> [Int]
perfects2 z = [xs | xs <- properFactors z, sum (properFactors z) == z]

perfects :: Int -> [Int]
perfects z = [xs | xs <- [1..z], length (perfects2 xs) /=  0]

-- fizzBuzz :: [String]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN] ,y <- [fromN..toN], z <- [fromN..toN], z < x, y/= x || y /= z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = if f x then True else any' f xs


--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f (x:xs) = foldr(\x acc -> if f x then True  else x && acc)


-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x = if p(f x) == True  then f x: while p f x else [f x]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error "cycle infni"
cycle' xs = xs ++ cycle' xs

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
