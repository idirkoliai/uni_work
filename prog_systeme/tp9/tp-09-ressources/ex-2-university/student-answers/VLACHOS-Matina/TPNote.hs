import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects limit = [n | n <- [1.. limit], sum(properFactors n) == n]

fizzBuzz :: [String]
fizzBuzz = [ f x | x <- [1..]] 
            where f n | n `mod` 5 == 0 && n `mod` 3 == 0 = "fizzbuzz"
                        | n `mod` 3 == 0 = "fizz"
                        | n `mod` 5 == 0 = "buzz"
                        | otherwise = show n

sameParity :: Int -> Int -> Int -> Bool
sameParity x y z | even x && even y && even z = True
                 | odd x && odd y && odd z = True
                 | otherwise = False

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, not(sameParity x y z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs) | p x = True
                | otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr f False xs 
                where f x acc | p x = True
                              | otherwise = any' p xs

--group' :: Eq a => [a] -> [[a]]
--group' [] = []
--group' (x : y : xs) | x == y = x : y : group' (y : xs)
--                    | otherwise = [x] ++ group' (y : xs)

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x | p x = x : while p f (f x)
            | otherwise = []

--syracuse :: Int -> [[Int]]
--syracuse 1 = []
--syracuse n | even n = let res = n `div` 2 in (while (== res) (\x -> x `div` 2) n) : syracuse res
--           | otherwise = let res = n * 2 + 1 in (while (== res) (\x -> 3 * x + 1) n) : syracuse res

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (k-1) f (f x0) 


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = concat(repeat xs)

--borders :: (Eq a) => [a] -> [[a]]
--borders xs = [x | x <- ]


--sublists :: Int -> [a] -> [[a]]
--sublists xs = [[n..] | n <- [1..n], x <- xs]

--select :: [a] -> [(a, [a])]
--select [] = []
--select xs'@(x : xs) = let new = delete x xs' in (x, new) : select xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, y1) (x2, y2) = (x2 <= x1 && x1 <= y2) || (x1 <= x2 && x2 <= y1)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [a] = True
unitI ((x, y) : (x2, y2) : xs) | (y - x) == y2 - x2 = unitI ((x2, y2) : xs)
                               | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [a] = True
isLeftSortedI ((x, y) : (x2, y2) : xs) | x <= x2 = isLeftSortedI ((x2, y2) : xs)
                                       | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1, y1) (x2, y2) = let x = minimum [x1, y1, x2, y2]; y = maximum [x1, y1, y2, x2] in (x, y)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [a] = [a]
coversLeftSortedI ((x, y) : (x2, y2) : xs) = coverI (x, y) (x2, y2) : coversLeftSortedI ((x2, y2) : xs)
