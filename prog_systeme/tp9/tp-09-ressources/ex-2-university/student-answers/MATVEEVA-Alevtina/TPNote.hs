import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [n' | n' <-[1..n-1],n `mod` n' == 0]

perfects :: Int -> [Int]
perfects k = [n' | n' <-[1..k],sum(properFactors n') == n']


fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..] ]
    where 
        f x 
            | x `mod` 15 == 0 = "fizzbuzz"
            | x `mod` 3 == 0 = "fizz"
            | x `mod` 5 == 0 = "buzz"
            |otherwise = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z)|x <- range , y <- range ,z <- range, z<x ,notsamey x y z , diffParity x y z]
    where 
        range =  [fromN..toN]
        notsamey x y z = y /= x || y /= z
        diffParity x y z = not ((even x && even y && even z) || (odd x && odd y && odd z))

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> if acc then acc else p x) False

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (\x acc -> if null acc then [x]:acc else if x == head(head acc) then ((x:head(head acc):(tail acc))) else [x]:acc ) []

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x 
    | p x = x : while p f (f x)
    |otherwise = []


syracuse :: Int -> [Int]
syracuse n 
    |n <= 0 = error "provide strictly positive values"
    |n == 1 = [1]
    |even n = n:syracuse (n`div`2)
    |otherwise = n : syracuse (3*n+1)


loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0: loop (k-1) f (f x0)
--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error "empty list"
cycle' xs  = (concat.repeat) xs

borders :: (Eq a) => [a] -> [[a]]
borders xs = [take i xs | i <- [0..length xs],take i xs == drop (length xs-i ) xs ]

sublists :: Int -> [a] -> [[a]]
sublists k xs =  reverse $ filter( \x->length x == k) $ allLists xs
    where 
        allLists [] = [[]]
        allLists (x:xs)  = allLists xs ++ [x:xs'| xs' <- allLists xs]


-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d) = foldr (\x flag -> if flag then flag else x `elem` [c..d]) False [a..b]


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI ((a,b):xs) = foldr (\(c,d) flag -> if not flag then flag else length [c..d] == length [a..b] ) True ((a,b):xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs =  go mapped
    where 
        mapped = map (fst) xs
        go [] = True
        go [x] = True
        go (x:y:xs) = x <= y && go (y:xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a,b) (c,d) = (min a c,max b d)


-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
