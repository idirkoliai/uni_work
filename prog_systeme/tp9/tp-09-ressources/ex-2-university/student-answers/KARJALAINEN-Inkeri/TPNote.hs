import Data.List

--
-- Exercice 1
--

-- exercice des pages jaunes des CM 
-- faite 
properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], mod n x == 0]

-- faite 
perfects :: Int -> [Int]
perfects n = [x | x <- [1..n - 1], sum(properFactors x) == x]

-- fizzBuzz :: [String]
-- fizzBuzz = [x | x <- [1..100], x `mod` 3 == 0 show "fizz", x `mod` 5 == 0 show "buzz", x `mod` 3 == 0 && x `mod` 5 == 0 show "fizzBuzz"]

-- faite
altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <-[fromN..toN], z <- [fromN..toN], z < x, (y /= x || y /= z), not((even x && even y && even z) || (odd x && odd y && odd z))]


--
-- Exercice 2
--

-- faite 
any' :: (a -> Bool) -> [a] -> Bool
any' p []       = False 
any' p (x : xs)
    | p x       = True 
    | otherwise = any' p xs 

-- faite 
any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr(\x acc -> if p x then acc else acc) True  -- par defaut, on commence à True et non False

-- group' :: Eq a => [a] -> [[a]]
-- group' xs = foldr(\x acc -> if (x == (tail xs)) then x : acc else acc) []

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
-- while p f x0 
    -- | p f x0    = x0 : p f x0
    -- | otherwise = []

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

-- faite 
cycle' :: [a] -> [a]
cycle' xs = concat(repeat xs)

borders :: (Eq a) => [a] -> [[a]]
borders []              = [[]]
borders [x]             = [[], [x]]
-- borders (x : xs)
    -- | x == head xs      = x ++ borders (tail xs)
    -- | otherwise         = borders (tail xs)
 
sublists :: Int -> [a] -> [[a]]
sublists 0 _            = [[]]
sublists _ []           = []
sublists k (x : xs)     = [[x]] ++ sublists k xs

select :: [a] -> [(a, [a])]
select []       = []
select [x]      = [(x, [])]
-- select (x : xs) = (x : tail xs) ++ select xs

partitions :: [a] -> [[[a]]]
partitions []       = [[]]
partitions [x]      = [[[x]]]
-- partitions (x : xs) = [xss] ++ [x : xs' | xs' <- xss]
    -- where 
        -- xss = partitions xs



--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
-- intersectI (x1: i1) (x2 : i2)
    -- | not(elem x1 x2)   = False
    -- | not

unitI :: [(Int, Int)] -> Bool
unitI []        = True
unitI [(x, y)]  = True

-- faite 
isLeftSortedI :: [(Int, Int)] -> Bool
-- relever les x de chaque couple et regarde si le x du premier couple est inférieur ou égal au x du prochain couple
-- en faire une boucle donc appel récursif 
isLeftSortedI []        = True 
isLeftSortedI (x : xs)
    | x <= head xs      = isLeftSortedI (tail xs) 
    | otherwise         = False 

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
-- le x : le plus petit des deux 
-- le y : le plus grand des deux 
-- coverI (x1 : y1: i1) (x2 : y2 : i2) = (plusPetitx, plusGrandY)
    -- where 
        -- plusPetitx
            -- | x1 <= x2  = x1 
            -- | otherwise = x2 
        -- plusGrandY
            -- | y1 >= y2  = y1 
            -- | otherwise = y2
        


-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
