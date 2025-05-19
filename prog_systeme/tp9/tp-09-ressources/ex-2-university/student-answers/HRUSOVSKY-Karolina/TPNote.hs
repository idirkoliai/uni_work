import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors :: Int -> [Int]
properFactors xs = [k | k <-[1..xs -1],  xs `mod` k  ==0]

-- perfects :: Int -> [Int]
perfects :: Int -> [Int]
perfects n = [k | k<-[1..n], sum (temp k) ==k ]
    where temp xs = [k | k <-[1..xs -1],  xs `mod` k  ==0]

-- fizzBuzz :: [String]
--fizzBuzz xs = show [res | res <-[1..100]]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<-[fromN, toN],y<-[fromN, toN],z<-[fromN, toN], z<x, y /=x , y ==z]





--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' :: (a -> Bool) -> [a] -> Bool
any' p xs = if length (filter p xs) > 0 then True else False

-- any'' :: (a -> Bool) -> [a] -> Bool
--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p xs = /x acc p foldr

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = takeWhile(p) map(f)(x0)

-- syracuse :: Int -> [Int]
--syracuse :: Int -> [Int]
--syracuse 

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]
borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[],[x]]
borders (x : xs) = if length(xs) == 1 then [[],x:xs] else borders xs




-- sublists :: Int -> [a] -> [[a]]
sublists :: Int -> [a] -> [[a]]
sublists k xs = if k == 0 then [[]] else subaux xs ++ prefixe xs
    where subaux xs =subaux(tail xs) ++ prefixe xs
          prefixe xs = prefixe(init xs ) ++ [xs]

-- select :: [a] -> [(a, [a])]
select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x,[])]
select (x:xs) = (x, xs) : select xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI i1 i2 = if 

-- unitI :: [(Int, Int)] -> Bool
unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
--unitI [(x,y):(k,w):xs] = if y -x == w-k then True else False

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
