import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [x | x <- [1..k], k `mod` x == 0, x < k]

--perfects :: Int -> [Int]
--perfects k = [x | x <- [1..k], sum . properFactors x == x]

--fizzBuzz :: [String]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = if f x then True else any' f xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f = foldr op False
--    where
--        op False [] = False
--        op _ (x:xs) = if f x then True else op False xs

-- group' :: Eq a => [a] -> [[a]]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = filter f (takeWhile p [x0..])

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = foldr (:) (cycle' xs) xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [a] = [[], [a]]
--borders (x:xs)
--    | x == head xs && x == last xs = x: borders xs
--    | otherwise = borders xs

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [] = []
sublists k (x:xs)
    | k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (i1_1, i1_2) (i2_1, i2_2) = if (i1_1 < i2_1 && i2_1 < i1_2) 
                                            || (i2_1 < i1_1 && i1_1 < i2_2) 
                                            then True else False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [_] = True
unitI [(x1, x2), (y1, y2)] = if x2 - x1 /= y2 - y1 then False else True
unitI ((x1, x2):(y1, y2):is) = if x2 - x1 == y2 - y1 then True else unitI is

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [_] = True
isLeftSortedI [(x1, x2),(y1, y2)] = if y1 > x1 then True else False
isLeftSortedI ((x1, x2):(y1, y2):is) = if y1 < x1 then False else isLeftSortedI ((y1, y2):is)

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
