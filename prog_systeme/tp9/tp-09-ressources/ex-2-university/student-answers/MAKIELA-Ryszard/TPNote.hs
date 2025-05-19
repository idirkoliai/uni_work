import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = filter (\x -> mod n x == 0) . take (n -1) $ iterate (+1) 1

perfects :: Int -> [Int]
perfects n = filter (\x -> sum (properFactors x) == x) . take (n -1) $ iterate (+1) 1

fizzBuzz :: [String]
fizzBuzz = map (\x -> if ((mod x 3 == 0) && (mod x 5 == 0)) then "fizzbuzz" else if (mod x 3 == 0) then "fizz" else if (mod x 5 == 0) then "buzz" else show x) $ iterate (+1) 1

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if (p x) then True else any' p xs 

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p (x:xs) = foldr p x xs

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


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

--intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
