import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [x | x <-[1..k-1], (k `mod` x) == 0]

perfects :: Int -> [Int]
perfects k = [x | x <- [1..k], (sum (properFactors x)) == x]

-- fizzBuzz :: [String]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, (y /= x || y /= z), ((even x) /= (even y) || (even x) /= (even z) || (even y) /= (even z))]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs) = p x || any' p xs 

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x || acc) False xs

--group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p (f x0) = x0 : while p f (f x0)
    | otherwise = x0 : [] 

syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse k
    | even k = k : syracuse (k `div` 2)
    | otherwise = k : syracuse (k * 3 + 1)

loop :: Int -> (a -> a) -> a -> [a]
loop 1 _ x0 = [x0]
loop k f x0 = x0 : loop (k - 1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = concat [xs, cycle' xs]

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, x2) (y1, y2) = (y1 >= x1 && y1 <= x2) || (x1 >= y1 && x1 <= y2)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [a] = True
unitI ((x1, x2) : (y1, y2) : xs) = (x2 - x1) == (y2 - y1) && unitI ((y1, y2) : xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [a] = True
isLeftSortedI ((x1, x2) : (y1, y2) : xs) = x1 <= y1 && isLeftSortedI ((y1, y2) : xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1, x2) (y1, y2) = (min, max)
    where
        min = if x1 <= y1 then x1 else y1
        max = if x2 <= y2 then y2 else x2

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [a] = [a]
coversLeftSortedI ((x1, x2) : (y1, y2) : xs)
    | unitI ((x1, x2) : (y1, y2) : xs) = ((x1, x2) : (y1, y2) : xs)
    | otherwise = if (intersectI (x1, x2) (y1, y2)) then coversLeftSortedI (coverI (x1, x2) (y1, y2) : xs)
