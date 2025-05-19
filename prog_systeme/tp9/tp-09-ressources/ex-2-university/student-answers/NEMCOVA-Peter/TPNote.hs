import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [c| c <- [1..n-1] , n `mod` c == 0 ]


perfects :: Int -> [Int]
perfects n = [c| c <- [1..n-1] , c == sum(properFactors c) ]

-- fizzBuzz :: [String]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = if f x then True else any' f xs


any'' :: (a -> Bool) -> [a] -> Bool
any'' e = foldr(\x acc -> e x || acc )False


group' :: Eq a => [a] -> [[a]]
group' = foldr(\x acc ->  [[x]] ++ acc)[]


-- while :: (a -> Bool) -> (a -> a) -> a -> [a]


-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--
cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle xs

-- borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists _ [] = []
sublists k (x:xs) 
    | k < 0 = []
    | otherwise = map (x:) (sublists  (k-1) xs) ++ sublists  k xs

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool
-- unitI (x:xs) = sum x == 


-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
