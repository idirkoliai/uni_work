import           Data.List


--
-- Exercice 1

properFactors :: Int -> [Int]
properFactors n = filter (\x-> n `mod` x == 0) [1..n `div` 2]

perfects :: Int -> [Int]
perfects n = filter (\x->sum (properFactors x) == n) [1..n]
        
transform :: Int -> String
transform x 
        | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
        | x `mod` 3 == 0 = "fizz"
        | x `mod` 5 == 0 = "buzz"
        |otherwise = show x

fizzBuzz :: [String]
fizzBuzz = [transform x|x<-[1..]]

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 a b = [(x,y,z)| z <- [1..a], x <- [z..]]


--
-- Exercice 2

{- any' :: (a -> Bool) -> [a] -> Bool
 any' f [] = False
 any' f (x:xs) = if (f x) then True else any' f xs-}

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while f p x0 = map f p 

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' (x:xs) = x : cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
--borders (x:xs) = y : xs ;

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
--sublists n xs = [x..y]

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
