import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], mod n x == 0]

calculParfait :: Int -> Bool
calculParfait n = sum (properFactors n) == n

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], calculParfait x]

--fizzBuzz :: [String]
--fizzBuzz = [x | x <- [1..], if mod x 3 == 0 then (if mod x 5 == 0 then x : "fizzBuzz" else x : "fizz") else x]

parityOdd :: Int -> Int -> Int -> Bool
parityOdd x y z = if (odd x == odd y) == odd z then False else True

parityEven :: Int -> Int -> Int -> Bool
parityEven x y z = if (even x == even y) == even z then False else True

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x,(x /= y || y /= z), (parityOdd x y z &&  parityEven x y z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
    | p x = True
    | otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> p x || acc) False

--group' :: Eq a => [a] -> [[a]]


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 
    | p x0 == False = []
    | otherwise = x0 : while p f (f x0)


calculSyracuse n 
    | even n = n/2
    | otherwise = n*3+1 

--syracuse :: Int -> [Int]
--syracuse 0 = []
--syracuse n = while (/= 0) (if even n then div n else (*3) ) n

--loop :: Int -> (a -> a) -> a -> [a]
--loop k f x0
--    | k == 0 = []
--    | otherwise = while


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
borders [x] = [[x]]


sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists _ [] = []
sublists k (x:xs)
    | k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs

--select :: [a] -> [(a, [a])]
--select [] = []
--select (x:xs)


partitions :: [a] -> [[[a]]]
partitions [] = [[]]
partitions [x] = [[[x]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d)
    | a > d = False
    | b < c = False
    | otherwise = True



-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
