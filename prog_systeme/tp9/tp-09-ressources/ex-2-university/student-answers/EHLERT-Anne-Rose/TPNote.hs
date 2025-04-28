import           Data.List

--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n], n `mod` x == 0, x /= n]

perfects :: Int -> [Int]
perfects 0 = []
perfects n = [x | x <- [1..n],sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [fizzB x | x <- [1..]]
    where
        fizzB x
            | x `mod` 5 == 0 && x `mod` 3 == 0 = "fizzbuzz"
            | x `mod` 3 == 0 = "fizz"
            | x `mod` 5 == 0 = "buzz"
            | otherwise = show x 


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | z <-[fromN..toN] ,x <-[z+1..toN], y <- [fromN..toN], isValid x y z, parite x y z]
    where
        parite x y z = let parX = x `mod` 2 in not (parX ==  y `mod` 2 && parX  == z `mod` 2)
        isValid x y z
            | y /= x = True
            | y /= z = True
            |otherwise = False
 
--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
    | p x = True
    |otherwise = any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool
-- any'' p xs = show (foldr p False xs) 

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (traite) [] xs
    --where
        --traite acc x
            -- x == head (acc) = 
            

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p x0 = x0 : while p f (f x0)
    | otherwise = [] 


syracuse :: Int -> [Int]
syracuse x = (while (/= 1) syra x) ++ [1]
    where   
        syra x
            | x `mod` 2 == 1 = x * 3 + 1
            | otherwise = x `div` 2 

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 
    | k == 0 = []
    | otherwise = x0 : loop (pred k) f (f x0) 


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders xs = "":xs ++ []

--sublists :: Int -> [a] -> [[a]]
--sublists n xs = [[x] | x <- xs]

--select :: [a] -> [(a, [a])]
--select (x:xs)
    --(x,xs) : select x:xs

-- partitions :: [a] -> [[[a]]]
-- partitions xs = [part | part <- [ ]]

--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

--unitI :: [(Int, Int)] -> Bool
--unitI (x:xs) = let a = head (x),b = tail(x), size = length [a..b] in filter () map () xs

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
