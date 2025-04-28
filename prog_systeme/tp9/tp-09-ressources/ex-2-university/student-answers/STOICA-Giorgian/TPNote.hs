import           Data.List


--
-- Exercice 1
--


properFactors :: Int -> [Int]
properFactors n =[d |d <- [1..n-1],n `mod` d==0]

estparfait :: Int -> Bool
estparfait n= sum(properFactors n) == n

perfects :: Int -> [Int]
perfects n= [x| x <-[1..n], estparfait x]



-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _[] =False
any' p (x:xs) =p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p =foldr (\x acc -> p x || acc) False


--group' :: Eq a => [a] -> [[a]]
--group' = folder f []
--    where 
--        f x []



-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error" cycle' :empty list"
cycle' xs =xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders 

sublists :: Int -> [a] -> [[a]]
sublists [] = [[]]
sublists (x:xs) = xss ++ map (x:) xss
    where
        xss = sublists xs

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI (x1,x2)



-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
