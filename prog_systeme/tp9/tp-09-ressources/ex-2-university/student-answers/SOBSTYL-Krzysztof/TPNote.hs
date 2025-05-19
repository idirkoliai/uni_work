import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where 
        f :: Int -> [Char]
        f x
         | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
         | x `mod` 3 == 0                   = "fizz"
         | x `mod` 5 == 0                   = "buzz"
         | otherwise                        = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, not(even x && even y && even z), not(odd x && odd y && odd z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = f x || any' f xs 


any'' :: (a -> Bool) -> [a] -> Bool
any'' f x =  foldr (||) False (g x)
    where 
        g :: [a] -> [Bool]
        g [] = []
        g (x:xs) = f x : g xs  

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = x ++ cycle' x

-- borders :: (Eq a) => [a] -> [[a]]
-- borders [] = []
-- borders (x:xs) = [[] ++ [x]]


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
