import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x = [y | y <- [1..x-1], x `mod` y == 0]

sumList :: [Int] -> Int
sumList xs = foldr (\x acc -> x + acc) 0 xs

perfects :: Int -> [Int]
perfects x = [y | y <- [1..x], sumList (properFactors y) == y]

-- fizzBuzz :: [String]
-- fizzBuzz = [y | y <- [1..], y == 3, y == 5]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
-- altParity3 fromn ton = [(x, y, z) | ton >= x, x >= fromn, ton >= y, y >= fromn, ton >= z, z >= fromn, z < x, not y == x || not y == z]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if p x then True else any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr(\x acc -> if p x then True else acc) False xs

--group' :: Eq a => [a] -> [[a]]
--group' (x:xs) = foldr(\x acc -> if x == head xs then [x:head xs] else acc) [] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | (p x0) = x0:(while p f(f x0))
    | otherwise = []

--syracuse :: Int -> [Int]

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = if k > 0 then x0 : loop (k-1) f (f x0) else []



--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders [_] = [""]
--borders (x:xs) = 

--sublists :: Int -> [a] -> [[a]]

--select :: [a] -> [(a, [a])]
--select (x:xs) = if x `elem` xs then (x, tail xs):select xs else []

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI i1 i2 = if (last i1) > head i2 then True else False

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
