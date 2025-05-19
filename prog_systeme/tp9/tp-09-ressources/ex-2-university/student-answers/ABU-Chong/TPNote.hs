import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [k | k <- [1..n-1] , n `mod` k == 0]

perfects :: Int -> [Int]
perfects n = [k | k <- properFactors n ,  sum (properFactors n) == n , n==k ]

-- fizzBuzz :: [String]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN] , y <- [fromN..toN] , z <- [fromN..toN]
                        , z < x , (y /= x || y /=z) &&
                        ((even x) && (odd y) || (even x) && (odd z))]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs


--any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
borders [x] = [[] , [x]]


sublists :: Int -> [a] -> [[a]]
sublists 0  _= [[]]
sublists n xs =  [k | k <- (subsequences  xs) ,(length k == n)]

select :: [a] -> [(a, [a])]
select xs = [(x,xs') | x <- xs , xs' <- dropWhile (/= x) xs]

partitions :: [a] -> [[[a]]]
partitions xs = [subsequences xs]

--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
