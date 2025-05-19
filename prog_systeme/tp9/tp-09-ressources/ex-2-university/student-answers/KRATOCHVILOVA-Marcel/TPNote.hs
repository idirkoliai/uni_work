import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1] , mod n x == 0]

perfects :: Int -> [Int]
perfects n = [ x | x <- [1..n], sum (properFactors x) == x] 


fizzBuzz :: [String]
fizzBuzz = [divBy x | x <- [1..]]
    where
        divBy n
            | mod n 5 == 0 && mod n 3 == 0 = "fizzbuzz"
            | mod n 3 == 0 = "fizz"
            | mod n 5 == 0 = "buzz"
            | otherwise = show n

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, (even x && odd y && odd z) || (even x && even y && odd z) || (odd x && odd y && even z) || (odd x && even y && odd z) || (odd x && even y && even z) || (even x && odd y && even z) ]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
    | p x = True
    | otherwise = False


any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> if p x then True else acc) False


--group' :: Eq a => [a] -> [[a]]
--group' = foldr (x acc -> if head acc ==  x then x : acc else [x] ++ acc) [[]]


while :: (a -> Bool) -> (a -> a) -> a -> [a] 
while p f x0 
    | not $ p (f x0) = [x0]
    | otherwise = x0 : while p f (f x0)


syracuse :: Int -> [Int]
syracuse = while (> 1) f 
    where
        f n
            | even n = div n 2
            | odd n = n * 3 + 1

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0
    | k == 1 = [x0]
    | otherwise = x0 : loop (k-1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[], [x]]
borders (x:xs) = occ : borders xs
    where occ = x : dropWhile (== x) xs


sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [x] = [[x]]

select :: [a] -> [(a, [a])]
select [] = []
--select lst = [(x, xs)| x <- take n lst, xs <- filter (== x) lst, n <- [1..length lst]]

partitions :: [a] -> [[[a]]]
partitions [] = [[]]

--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (x, y) = isOnList [a..b] [x..y]
    where
        isOnList [] _ = False
        isOnList _ [] = False 
        isOnList (x:xs) ys
            | elem x ys = True
            | otherwise = isOnList xs ys

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI ((a,b):(x,y):xs) = length [a..b] == length [x..y] && unitI ((x,y):xs) 

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI ((a,b):(x,y):xs) = a < x && isLeftSortedI ((x,y):xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a, b) (x, y) = (x, b)

--coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
