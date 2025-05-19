import          Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [n' | n'<-[1..n-1],n `mod` n' == 0]

perfects :: Int -> [Int]
perfects k = [n' | n'<- [1..k],sum(properFactors n') == n']

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
  where
    f x
      | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
      | x `mod` 3 == 0 = "fizz"
      | x `mod` 5 == 0 = "buzz"
      | otherwise = show x
      


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<-[fromN..toN], y<-[fromN..toN], z<-[fromN..toN], z<x, (x /= y)|| (y /= z), not ((even x && even y && even z) || (odd x && odd y && odd z))]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr(\x acc -> if acc then acc else p x) False

-- group' :: Eq a => [a] -> [[a]]
-- group' xs = foldr(\x acc -> if null acc then [x]:acc else if x == head(head acc) then (x:head(head acc):tail acc else [x]:acc)) []


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p x0 = x0:while p f (f x0)
    | otherwise = []


syracuse :: Int -> [Int]
syracuse n
    | n <= 0 = error "not a positive value"
    | n == 1 = [1]
    | even n = n : syracuse (n `div` 2)
    | otherwise = n : syracuse (3*n+1)

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0:loop(k-1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders xs = [take i xs | i <- [0..length xs], take i xs == drop(length xs-i) xs]

sublists :: Int -> [a] -> [[a]]
sublists _ [] = [[]]
sublists k (x:xs) = filter (\x -> length x == k) $ sublists k xs ++ [x:xs' | xs' <- sublists k xs]

select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = [(x,xs)]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
-- intersectI (a,b) (c,d) = foldr(\x flag -> if flag then flag else x `elem` [c..d]) False

-- unitI :: [(Int, Int)] -> Bool
-- unitI [] = True
-- UnitI ((a,b):xs) = foldr (\(c,d) flag -> if not fllag then flag else length [c..d] == length [a..b]) False

-- isLeftSortedI :: [(Int, Int)] -> Bool

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a,b) (c,d) = (min a c, max b d)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]


