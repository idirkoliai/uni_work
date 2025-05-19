import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

sum' [] = 0
sum' [a] = a
sum' (x:xs) = x + sum' xs
-- perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], (sum' (properFactors x)) == x]

-- fizzBuzz :: [String]
-- fizzBuzz = [show x | x <- [1..], ]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, parite (x,y,z)]
    where
        parite (x,y,z)
            | x `mod` 2 == 0 && y `mod` 2 == 0 && z `mod` 2 == 0 = False
            | x `mod` 2 /= 0 && y `mod` 2 /= 0 && z `mod` 2 /= 0 = False
            | otherwise = True

--
-- Exercice 2
--any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p [a] = p a 
any' p (x:xs)
    | p x == True = True
    | otherwise  = any' p xs

--any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = logique (foldr p [] xs)
    where
        logique [] = False
        logique [xs] = xs
        logique (x:xs)
            | x == True = True 
            | otherwise = logique xs

-- group' :: Eq a => [a] -> [[a]]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = filter p (map f [x0..])

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs = (f [] xs) ++ cycle' xs
    where 
        f acc [] = acc
        f acc (x:xs) = x : acc ++ (f acc xs)

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]
select (x:xs) = [(x, prv x xs) | x <- xs]
    where 
        prv n (x:xs)
            | n == x = xs
            | otherwise = [x] ++ (prv n xs)

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a, b) (c, d)
    | a >= c && a <= d = True
    | b >= c && b <= d = True
    | a >= c && b <= d = True
    | c >= a && d <= b = True
    | otherwise = False

long (a, b) = length [a..b]
-- unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [a] = True
unitI (x:xs) = sum ([long x | x <- (x:xs)]) == ((long x) * length xs)
-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
