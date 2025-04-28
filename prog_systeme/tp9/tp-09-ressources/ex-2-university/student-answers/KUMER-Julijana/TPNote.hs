import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [p | p <- [1 .. n - 1], mod n p == 0]

perfects :: Int -> [Int]
perfects n = [p | p <- [1 .. n - 1], sum (properFactors p) == p]

--fizzBuzz :: [String]
--fizzBuzz = [n | n <- "":fizzBuzz, mod n 3 == 0, mod n 5 == 0]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN .. toN], y <- [fromN .. toN], z <- [fromN .. toN], z < x, y /= x || y /= z, (odd x && odd y && even z) || (odd x && even y && odd z) || (even x && odd y && odd z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p [x] = p x 
any' p (x : xs) = p x || any' p xs


--any'' :: (a -> Bool) -> [a] -> Bool
--any'' = foldr f []
--    where
--        f p [] = False
--        f p (x : xs)
--            | p x
            
        


--group' :: Eq a => [a] -> [[a]]
--group' xs  = foldr f []
--    where 
--        f acc x = if x == 



while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 
    | p (f x0) = x0 : while p f (f x0)
    | otherwise = []




--syracuse :: Int -> [Int]
--syracuse n = while (/= 1) (if mod n 2 == 0 then n / 2 else n * 3 + 1) n

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


--borders :: (Eq a) => [a] -> [[a]]


sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [] = []
sublists k (x : xs)
    | k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs



select :: [a] -> [(a, [a])]
select [] = []
select (x : xs) = [(x, xs)] ++ select xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = let int11 = fst i1
                       int12 = snd i1
                       int21 = fst i2
                       int22 = snd i2
                   in (int21 <= int11 && int11 <= int22) || (int21 <= int12 && int12 <= int22) || (int11 <= int21 && int21 <= int12)|| (int11 <= int22 && int22 <= int12)



unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [(_,_)] = True
unitI (i1 : i2) = (snd i1 - fst i1) == (head snd i2 - head fst i2) && unitI i2

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
