import           Data.List


--
-- Exercice 1
--

--properFactors :: Int -> [Int]
--properFactors x = let [1..x] numbers = in [y<-numbers | if x `div` y]

--perfects :: Int -> [Int]

--fizzBuzz :: [String]
--fizzBuzz = let numbers iterate(\x -> x+1)1 in [x<-numbers | if x `mod` 3 == 0 then if x `mod` 5 == 0 then ]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 a b = [(x,y,z) | x<-[a..b], y<-[a..b], z<-[a..b], z<x, (y/=x || y/=z) &&  (x `mod` 2 /= y `mod` 2 || x `mod` 2 /= z `mod` 2 || z `mod` 2 /= y `mod` 2)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) =  if p x then True else any' p xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p xs = foldr(\x acc -> if p x then acc = True else acc ) False xs

--group' :: Eq a => [a] -> [[a]]
--group' = foldr(\x acc -> acc : x, if x== head(xs) then acc : head(xs) else acc )[[]] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f r 
    | p r = r : while p f (f r) 
    | otherwise = []

--syracuse :: Int -> [Int]
--syracuse a = while (/=1) (`div` 2) a

loop :: Int -> (a -> a) -> a -> [a]
loop p f r 
    | p /= 0 = r : loop (p-1) f (f r) 
    | otherwise = []

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists k [] = []
sublists k (x:xs)
    | k <= length(x:xs) = [x] : sublists k xs
    | otherwise = []

--select :: [a] -> [(a, [a])]
--select [] = []
--select [x] = [(x,[])]
--select (x:xs) = (x,)

--partitions :: [a] -> [[[a]]]
--partitions [] = [[]]
--partitions [x] = [[[x]]]
--partitions xs =

--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (z,a) = if y <= a && y >= z then True else if a <= y && a >= x then True else False  

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI ((a,b):(c,d):xs) 
    | b-a == d-c = unitI ((c,d):xs)
    | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI ((a,b):(c,d):xs) 
    | a <= c = isLeftSortedI ((c,d):xs)
    | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a,b) (c,d) = (a `min` c, b `max` d)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [x] = [x]
coversLeftSortedI ((a,b):(c,d):xs)
    | intersectI (a,b) (c,d) = coversLeftSortedI (coverI (a,b) (c,d):xs)
    | otherwise = (a,b) : coversLeftSortedI ((c,d):xs)
