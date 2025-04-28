import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [n1 | n1 <- [1..n `div` 2], n `mod` n1 == 0 ]

perfects :: Int -> [Int]
perfects n = [s | s <- [1..n], sum (properFactors s) == s]

--fizzBuzz :: [String]
--fizzBuzz = [n | n <- [1..], ]

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 fromN toN = [(x,y,z) | , (x > z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x) False xs

--group' :: Eq a => [a] -> [[a]]
--group' (x:xs) = x : foldr (\n acc -> n == x) [[]] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
   | p x0 = x0 : while p f (f x0)
   | otherwise = []

syracuse :: Int -> [Int]
syracuse n = while (> 1) (\x -> if even x then x `div` 2 else (3 * x) + 1) n ++ [1]


--loop :: Int -> (a -> a) -> a -> [a]
--loop k f' x0 = 


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs'@(x:xs) = (x : cycle' xs) ++ cycle' xs'

borders :: (Eq a) => [a] -> [[a]]
borders  [] = [] 
borders [a] = [[], [a]]


--sublists :: Int -> [a] -> [[a]]
--sublists k (x:xs) = 

--select :: [a] -> [(a, [a])]
--select 

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI prem sec = if (fst prem < fst sec) && (snd prem > fst sec) || (fst sec < fst prem) && (snd sec > fst prem) then True else False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [(a)] = True
unitI (x:y:xs) = (snd x - fst x) == (snd y - fst y) && unitI (y:xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [a] = True
isLeftSortedI (x:y:xs) = (fst x <= fst y) && isLeftSortedI (y:xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI i1 i2 = (if fst i1 <= fst i2 then fst i1 else fst i2, if snd i1 >= snd i2 then snd i1 else snd i2)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [a] = [a]
