import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n `div` 2], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where
        f :: Int -> String
        f x
            | x `mod` 15 == 0   = "fizzbuzz"
            | x `mod` 3 == 0    = "fizz"
            | x `mod` 5 == 0    = "buzz"
            | otherwise         = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], f (x, y, z)]
    where
        f :: (Int, Int, Int) -> Bool
        f (x, y, z) = (z < x) && (y /= x || y /= z)
            && not ((even x && even y && even z) || (odd x && odd y && odd z))


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs)
    | p x           = True
    | otherwise     = False || (any' p xs)

-- any'' :: (a -> Bool) -> [a] -> Bool
-- any'' p xs = foldr (&&) p xs

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p x0          = x0 : (while p f (f x0))
    | otherwise     = []

syracuse :: Int -> [Int]
syracuse n = (while (/= 1) f n) ++ [1]
    where
        f :: Int -> Int
        f n
            | even n    = n `div` 2
            | otherwise = n * 3 + 1

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0
    | k == 0        = []
    | otherwise = x0 : (loop (k-1) f (f x0))

--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
-- cycle' xs = 

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
