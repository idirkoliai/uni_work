import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [a | a <- [1..n-1], n == ((n `div` a) * a)]

perfects :: Int -> [Int]
perfects n = [a | a <- [1..n], a == sum(properFactors a)]

-- fizzBuzz :: [String]
-- fizzBuzz = map show ["test"]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x && (y /= x || y /= z) 
                    && not (even x == even y && even y == even z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs)
    | p x == True = True
    | otherwise = any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p x0 == True = x0 : while p f (f x0)
    | otherwise = []

syracuse :: Int -> [Int]
syracuse x = while (/=1) go x ++ [1]
    where
        go a
            | even a = a `div` 2
            | otherwise = 3*a+1


loop :: Int -> (a -> a) -> a -> [a]
loop k f x0
    | k == 0 = []
    | otherwise = x0 : loop (k-1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders xs = go (inits xs)
    where
        -- go :: (Eq a, b) => [[b]] -> [[b]]
        go [] = []
        go (y:ys)
            | y == xs = y : go ys
            | y == (drop ((length xs) - (length y)) xs) = y : go ys
            | otherwise = []

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = go [fst i1..snd i1] [fst i2..snd i2]
    where
        go (x:xs) ys
            | xs == [] = False
            | ys == [] = False
            | x `elem` ys = True
            | otherwise = go xs ys


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:y:xs)
    | snd x - fst x == snd y - fst y = unitI (y:xs)
    | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI(x:y:xs)
    | fst x <= fst y = isLeftSortedI (y:xs)
    | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI xs ys = (min (fst xs) (fst ys), max (snd xs) (snd ys) )

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [x] = [x]
coversLeftSortedI (x:y:xs)
    | intersectI x y == True = coversLeftSortedI ((coverI x y):xs)
    | otherwise = x : coversLeftSortedI (y:xs)
