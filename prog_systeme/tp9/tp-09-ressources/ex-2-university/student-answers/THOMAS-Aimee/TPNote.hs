import Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1 .. n - 1], n `mod` x == 0]

perfect :: Int -> [Int] -> Bool
perfect n facts = n == sum facts

perfects :: Int -> [Int]
perfects n = [n' | n' <- [1 .. n], n' `perfect` properFactors n']

fizzBuzzAnnexe :: Int -> String
fizzBuzzAnnexe n = if and [n `mod` 3 == 0, n `mod` 5 == 0] then "fizzbuzz"
    else if n `mod` 3 == 0 then "fizz"
    else if n `mod` 5 == 0 then "buzz"
    else show n

fizzBuzz :: [String]
fizzBuzz = [fizzBuzzAnnexe n | n <- [1 .. ]]

allSameParity :: [Int] -> Bool
allSameParity (x : xs) = foldr (\y acc -> and [f y, acc]) True xs
    where f = if even x then even else odd

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | 
    x <- [fromN .. toN],
    y <- [fromN .. toN],
    z <- [fromN .. toN],
    and [z < x, y /= x || y /= z, not (allSameParity [x, y, z])]]


--
-- Exercice 2s
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x : xs) = if p x then True else any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x || acc) False xs

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0 : while p f (f x0) else []

syracuseAnnexe :: Int -> Int -- Calcule la suite au rang n
syracuseAnnexe n = if even n then f1 n else f2 n
    where 
        f1 n = n `div` 2
        f2 n = n * 3 + 1

syracuse :: Int -> [Int]
syracuse n = (while (/= 1) syracuseAnnexe n) ++ [1]


loop :: Int -> (a -> a) -> a -> [a]
loop 1 f x0 = [x0]
loop k f x0 = x0 : loop (k-1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' (x : xs) = x : cycle' (xs ++ [x])

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- ! arreté ici !
--selectAnnexe :: a -> [a] -> [a] -- Retire toutes les itérations de `x`
--selectAnnexe x [] = []
--selectAnnexe x ys = foldr f [] ys
    --where
        --f x (y : ys) = if x == y then ys else y : ys  

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
