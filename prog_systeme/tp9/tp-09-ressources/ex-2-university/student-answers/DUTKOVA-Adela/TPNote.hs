import  Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n  = [x | x <- [1..n-1], mod n x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

div3and5:: Int -> Bool
div3and5 x = (mod x 3 == 0) && (mod x 5 == 0)

showlist :: [String]
showlist = [show x | x <- [1..]]

--fizz :: [String]
--fizz = ["fizzBuzz" | x <- [1..16], div3and5 x]

--fizzBuzz :: [String]
--fizzBuzz = ["fizz" | x <- [1..16], mod x 3 == 0]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 a b = [(x,y,z) | x <- [a..b], y <- [a..b], z <- [a..b-1], z < x, y/= x || y /= z]



--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) =  if f x then True else any' f xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f xs  = foldr f xs



--group' :: Eq a => [a] -> [[a]]
--group' [] = []


--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = if p x0 then (f x0) : while

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]


--sublists :: Int -> [a] -> [[a]]
--sublists 0 _ = []


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
