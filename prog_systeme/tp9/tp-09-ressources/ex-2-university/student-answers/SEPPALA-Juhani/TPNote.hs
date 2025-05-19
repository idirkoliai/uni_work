import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n-1], x == sum (properFactors x)]

aux1 :: Int -> [String]
aux1 n 
    | (n `mod` 3) == 0 &&  (n `mod` 5) == 0 = ["fizzbuzz"]
    | (n `mod` 5) == 0 = "buzz" : aux1 (n+1)
    | (n`mod` 3) == 0 = "fizz" : aux1 (n+1)
    | otherwise = show n : aux1 (n+1)

fizzBuzz :: [String]
fizzBuzz = [x |x <- aux1 1]

aux2 :: Int -> Int -> Int -> Bool
aux2 x y z 
    | even x && even y && even z = False 
    | odd x && odd y && odd z = False 
    | otherwise = True

aux3 :: Int->Int->Int->Bool 
aux3 x y z 
    | y/=x || z/=x = True
    | otherwise = False

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x,aux3 x y z ,aux2 x y z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False 
any' f (x:xs) = f x || any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs = foldr (\x acc -> f x || acc) False xs

-- group' :: Eq a => [a] -> [[a]]
-- group' xs = foldr (\x acc -> if x == acc then x:acc else acc) [] [xs] 

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 
    | p x0 == False = []
    | otherwise =x0 : while p f (f x0)

syracuse :: Int -> [Int]
syracuse n = while (> 1) (\x -> if even x then x`div`2 else x*3 + 1 ) n ++ [1]

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (k-1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders null = []
--borders [x] = [[],[x]]

aux4 :: Int -> a -> [a] -> [[a]]
aux4 n x null = []
aux4 0 _ _ = []
aux4 n x (y:xs) = [x] : aux4 (n-1) y xs

sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists n xs 
    | n > length xs = []
    | n == length xs = [xs]
    | otherwise = [xs]

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
