import           Data.List


--
-- Exercice 1
--s 

properFactors :: Int -> [Int]
properFactors xs = [ x | x <- [1..xs-1] , mod xs x == 0]

perfects :: Int -> [Int]
perfects xs = [ x | x <- properFactors xs, sum (properFactors xs) == xs ]
  where
    sum (x:xs) = x + sum xs

--fizzBuzz :: [String]
--fizzBuzz = [x | x <- show 1.. , mod 1.. 3 == 1 || mod 1.. 5 == 1 ] ++ [ x | x <- "fizz" , mod 1.. 3 == 0 ] ++ [ x | x <- "buzz" , mod 1.. 5 == 0] ++ [ x | x <- "fizzbuzz" , mod 1.. 5 && mod 1.. 3 == 0]

--altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

--any' :: (a -> Bool) -> [a] -> Bool
--any' _ [] = False
--any' p (x:xs) 
-- | p x
-- | otherwise any' p xs 

-- any'' :: (a -> Bool) -> [a] -> Bool

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (\acc x -> acc == x) []

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 
--  | p (f x0) = x0 : f x0
--  | otherwise while p f $ f x0

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

--select :: [a] -> [(a, [a])]
--select [] = []
--select xs = [ (x,[y]) | x <- xs  , y <- xs , x /= y ]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
