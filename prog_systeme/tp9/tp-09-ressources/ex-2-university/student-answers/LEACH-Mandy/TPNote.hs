import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], mod n x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1 .. n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where
    f x = if mod x 3 == 0 && mod x 5 == 0 then "fizzbuzz" else if mod x 3 == 0 then "fizz" else if mod x 5 == 0 then "buzz" else show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, not (even x && even y && even z), even x || even y || even z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs)
    |p x == True = True
    |otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr(\x b -> p x) False xs 

-- group' :: Eq a => [a] -> [[a]]
-- group' xs = foldr(\x b -> if [x] == b then x : b else [x] ++ b) [] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 
    | p x0 == True = x0 :  while p f (f x0)
    |otherwise = []

-- syracuse :: Int -> [Int]


loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0
    | otherwise = x0 : loop (k -1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xss = xss ++ cycle' xss

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, y1) (x2, y2)
    | x1 >= x2 && x1 <= y2 = True
    | x1 == y1 = False
    | otherwise = intersectI (x1 + 1, y1) (x2, y2)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI ((x, y) : xs)
    | length xs /= 0 = y - x == sumxy xs && unitI xs
    | otherwise = True
    where
        sumxy ((x1, y1) : xss) = y1 - x1

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI ((x, y) : xs)
    | length xs /= 0 = x <= nextx xs && isLeftSortedI xs
    | otherwise = True
    where
        nextx  ((x1, y1) : xss) = x1

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1, y1) (x2, y2) = (minimum [x1, x2], maximum[y1, y2])


coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI ((x1, y1): xs)
    | length xs /= 0 && intersectI (x1, y1) (head xs) == True = coverI (x1, y1) (head xs) : coversLeftSortedI xs
    | otherwise = (x1, y1) : coversLeftSortedI xs
