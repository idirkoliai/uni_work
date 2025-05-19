import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n - 1], n `mod` x == 0]


-- perfects :: Int -> [Int]
perfects :: Int -> [Int]
perfects n = [x | x <- properFactors n]


-- fizzBuzz :: [String]
fizzBuzz :: [String]
fizzBuzz = [ show x | x <- [1..], x `mod` 3 == 0 || x `mod` 5 == 0  || (x `mod` 3 == 0 && x `mod` 5 == 0)]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' :: (a -> Bool) -> [a] -> Bool
any' _ []   = False
any' p (x:xs) 
    | p x       = True
    |otherwise  = any' p xs



-- any'' :: (a -> Bool) -> [a] -> Bool
any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> if p x then True else acc) False



-- group' :: Eq a => [a] -> [[a]]
--group' :: Eq a => [a] -> [[a]]
--group' = foldr (\x acc -> if x == x then x:acc else acc) []



-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
-- while :: (a -> Bool) -> (a -> a) -> a -> [a]




-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


-- borders :: (Eq a) => [a] -> [[a]]
borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
--borders [x] = [[x]]
--borders (x:y:xs) 
--    | x == y = x:y:



-- sublists :: Int -> [a] -> [[a]]
--sublists :: Int -> [a] -> [[a]]
--sublists 0 _ = [[]]
--sublists _ xs = [[]]
--sublists k (x:xs) =  


-- select :: [a] -> [(a, [a])]
select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
select (x:xs) = (x, xs) : select xs





-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI i1 i2 = (fst i1 < fst i2 && snd i1 < snd i2) || (fst i1 > fst i2 && snd i1 > snd i2)
--intersectI i1 i2 = 



-- unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:y:xs) 
    | length [fst(x)..snd(x)] /= length [fst(y)..snd(y)] = False
    | otherwise = unitI xs




-- isLeftSortedI :: [(Int, Int)] -> Bool
-- isLeftSortedI :: [(Int, Int)] -> Bool



-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
