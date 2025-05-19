import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [x | x <- [1..k-1], k `mod` x == 0]

-- perfects :: Int -> [Int]

--fizzBuzz :: [String]
--fizzBuzz x = [show x | x <- [1..k-1], if x `mod` 3 == 0 && x `mod` 5 == 0 then x = fizzbuzz else if x `mod` 3 == 0 then x = fizz else if  x `mod` 5 == 0 then x = buzz else x = x]
--fizzBuzz =
--     x `mod` 3 == 0 && x `mod` 5 == 0 = 'fizzbuzz'
--    | x `mod` 5 == 0 = 'buzz'
--    | x `mod` 3 == 0 = 'fizz'
--    | otherwise show x
--    where 
--        x <- [1..]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p [x] = p x
any' p (x : xs) = if p x then True else any' p xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p xs = if foldr p xs then True else 

--group' :: Eq a => [a] -> [[a]]
--group' [] = []
--group' [x] = x
--group' (x : xs) = if foldr (==) x xs then x = x else x = (:)

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if (p x0) then x0 : (while p f (f x0)) else []

syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse k
    | k `mod` 2 == 0 = k : syracuse (k `div` 2)
    | otherwise = k : syracuse ((k * 3) + 1)

--loop :: Int -> (a -> a) -> a -> [a]
--loop k f x0 = (while (<= k) (f) (x0))

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
--borders [\"\"] = [\"\"]
borders [x] = [[x]]
borders (x : xs) = if x == head (reverse xs) then [x] : (borders xs) else []

sublists :: Int -> [a] -> [[a]]
sublists _ [] = [] 
--sublists k xs = 

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2
    | (fst i1 < fst i2) && (snd i1 > fst i2) = True
    | (fst i1 > fst i2) && (snd i1 > fst i2) && (snd i2 > fst i1) = True
    | otherwise = False

--unitI :: [(Int, Int)] -> Bool

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI is = True
--isLeftSortedI (is : i2 : iss) = if (fst is) > (fst i2) then False else unitI (i2 : iss)

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
