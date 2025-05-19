import Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [ i | i <- [1..(n-1)], mod n i == 0]

perfects :: Int -> [Int]
perfects n = [i | i <- [1..n], sum (properFactors i) == i]

fizzBuzz :: [String]
fizzBuzz = [if (mod i 3) == 0 && (mod i 5) == 0 then "fizzbuzz" else if (mod i 3) == 0 then "fizz" else if (mod i 5) == 0 then "buzz" else "i"| i <- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [ (x,y,z)|x <- [fromN..toN],y <- [fromN..toN],z <- [fromN..toN], (z < x) && not(y == x && y == z) &&  not(x==y && y==z && z==x)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = f x || any' f xs 

any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs = let ys = map(f) xs in foldr (||) False ys

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (\x (y:ys)-> if x == y then x : y :ys else [x]) [] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a] 
while p f x0 
        | p x0 = x0 : while p f (f x0)
        | otherwise = [x0]

syracuse :: Int -> [Int]
syracuse x = while (/=1) (\y -> if even y then div y 2 else (y*3)+ 1) x

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k $ iterate f x0

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = concat $ repeat xs

--borders :: (Eq a) => [a] -> [[a]]
--borders [] = [[]]
--borders (x:xs)

rotate :: [a] -> [a]
rotate xs = (tail xs) ++ [head xs]

sublists :: Int -> [a] -> [[a]]
sublists _ [] = [] 
sublists x xs = [take x xs| ]

select :: (Eq a) => [a] -> [(a, [a])] -- j'ai ajouter Eq a
select xs'@(x:xs) = [(i, (delete i xs')) | i <- xs'] 

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (a,b) = x < a && a < y  || x > a && x < b || x < b && b < y  || y > b && y < a

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI xs@((x,y):xs') = null $ [i | i <- (unitb xs), (y-x) /= i]
    where
        unitb [] = []   
        unitb ((x,y) : xs) = (y-x) : unitb xs

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [(a,b)] = True
isLeftSortedI ((x,y):(a,b):xs) = (x <= a) && isLeftSortedI ((a,b):xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a,b) (x,y) = (min a x, max b y) 

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [(a,b)] = [(a,b)]
coversLeftSortedI ((a,b):(x,y):xs)
    | b < x = (a,b) : coversLeftSortedI ((x,y):xs)
    | otherwise = coversLeftSortedI ((a,max y b):xs)
