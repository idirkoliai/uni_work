import Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors 0 = []
properFactors n = [x | x <- [1..(n-1)], n `mod` x == 0]

sommeEgaux :: Int -> [Int] -> Bool
sommeEgaux n xs = (sum xs) == n

perfects :: Int -> [Int]
perfects n = 
    let
        sommeEgaux m xs = (sum xs) == m
    in [y | y <- [1..n], sommeEgaux y (properFactors y)]


fizzBuzzAux :: Int -> String
fizzBuzzAux n 
    | (n `mod` 3 == 0) && (n `mod` 5 == 0) = "fizzbuzz"
    | n `mod` 3 == 0 = "fizz"
    | n `mod` 5 == 0 = "buzz"
    | otherwise = show n


fizzBuzz :: [String]
fizzBuzz = [fizzBuzzAux x | x <- [1..]]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p xs
    | p $ head xs = True
    | otherwise = any' p (tail xs)

any'' :: (a -> Bool) -> [a] -> Bool
any'' _ [] = False
any'' p xs = foldr (\x acc -> (p x) || acc) False xs

-- group' :: Eq a => [a] -> [[a]]


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 
    | not $ p x0 = []
    | otherwise  = x0 : while p f (f x0)


-- syracuse :: Int -> [Int]

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (k-1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs =
    let
        cycleAux [] = cycleAux xs
        cycleAux (x:xss) = x:cycleAux xss
    in cycleAux xs

-- borders :: (Eq a) => [a] -> [[a]]

sublistsAux :: [a] -> [[a]]
sublistsAux [] = [[]]
sublistsAux (x:xs) = xss  ++  [x:xs | xs <- xss]
    where xss = sublistsAux xs

sublists :: Int -> [a] -> [[a]]
sublists k xs = reverse $  filter (\x -> (length x) == k) $ sublistsAux xs

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 =
    let 
        intersectIAux i1' i2'
            | fst i1' >= fst i2' = True
            | snd i1' >= fst i2' = True
            | otherwise = False
        in intersectIAux i1 i2 && intersectIAux i2 i1

-- unitI :: [(Int, Int)] -> Bool

isLeftSortedIAux :: [(Int, Int)] -> [(Int, Int)]
isLeftSortedIAux  xs = zipWith (\x y -> (fst x, fst y)) xs tail xs

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI is = all (\x -> (fst x) <= (snd x)) $ isLeftSortedIAux is


-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
