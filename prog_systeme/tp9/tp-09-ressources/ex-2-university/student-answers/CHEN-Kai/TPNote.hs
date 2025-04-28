import           Data.List


--
-- Exercice 1
--
properFactors :: Int -> [Int]
properFactors n = [x | x <-[1..(n-1)], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [show x | x <- [1..], x `mod` 3 == 0]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN],  y <- [fromN..toN],  z <- [fromN..toN], z < x, not (y == x) || not (y == z), not (odd x && odd y && odd z), not (even x && even y && even z)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr f False
    where
        f y acc
            | p y = True
            | otherwise = acc

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr f [head xs] xs
--    where
--        f y acc
--            | y == (head acc) = (y : head acc : []) ++ acc
--            | otherwise = [y] ++ acc

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x
    | p x = x : (while p f (f x))
    | otherwise = []
        

syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse n 
    | even n = n : syracuse (n `div` 2)
    | otherwise = syracuse (n * 3 + 1)  


loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x = x : (loop (k-1) f (f x))

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders [] = [[]]
--borders [x] = [x]
--borders xs
--   | (head xs) == head

help :: [a] -> [[a]]
help [] = [[]]
help (x:xs) = map (x:) xss ++ xss
    where
        xss = help xs

sublists :: Int -> [a] -> [[a]]
sublists k = filter ((==) k . length) . help

privee :: (Eq a) => a -> [a] -> [a]
privee _ [] = []
privee y (x:xs)
    | y == x = xs
    | otherwise = y : (privee y xs)


select :: (Eq a) => [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
select xs'@(x:xs) = (x, (privee x xs')) : (select xs)
-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
